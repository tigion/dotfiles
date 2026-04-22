#!/usr/bin/env bash

# NOTE: This script relies on `du`, whose behavior differs between
#       GNU (Linux) and BSD (macOS). Reported sizes may not match
#       `ls -l` due to block size rounding and directory accounting.

set -euo pipefail

# --- Parameters -----------------------------------------------------

path="${1:-.}"
cd "$path" || {
  printf "Error: Cannot access path '%s'" "$path" >&2
  exit 1
}

# --- Config / Globals -----------------------------------------------

# Config
BAR_LENGTH=10

# Colors
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_NONE="\033[0m"

# Global data variables
files=() file_count=0
sizes=() size_strs=() names=()
max_size=0 max_size_str_len=0
summary_size=0

# --- Function Libraries ---------------------------------------------

lib_file="$HOME/lib/bytes_to_human.sh"
if [[ ! -r "$lib_file" ]]; then
  echo "Error: Cannot read $lib_file" >&2
  exit 1
fi
# shellcheck disable=SC1090
source "$lib_file" || exit 1

# --- Functions ------------------------------------------------------

usage() {
  echo "Usage: $(basename "$0") [path]"
}

get_files() {
  shopt -s nullglob dotglob
  files=(*)
  shopt -u nullglob dotglob
}

get_size_with_du() {
  local file=$1
  local size=0
  # `NR==1` handles possible newlines in filenames safely.
  # Alternatively: `du -sk "./$file" ...` instead of `du -sk -- "$file" ...`
  size=$(du -sk -- "$file" 2>/dev/null | awk 'NR==1 {print $1}')
  # Converts the size from kilobytes to bytes.
  echo "$((size * 1024))"
}

calc_sizes() {
  local idx=0
  local file size size_str size_str_len name

  for file in "${files[@]}"; do
    printf '\rCalculating: %s/%s ...' "$((idx + 1))" "$file_count"

    # Escapes the file name for safe printing.
    name=$(printf '%q' "$file")

    if [[ -e "$file" ]]; then
      if [[ -L "$file" ]]; then
        name="${name}@"
      elif [[ -d "$file" ]]; then
        name="${name}/"
      fi
      size=$(get_size_with_du "$file")
    else
      name="! ${name} (no size)"
      size=0
    fi

    ((size > max_size)) && max_size=$size
    size_str=$(bytes_to_human "$size")

    size_str_len=${#size_str}
    ((size_str_len > max_size_str_len)) && max_size_str_len=$size_str_len

    sizes[idx]=$size
    size_strs[idx]=$size_str
    names[idx]=$name

    summary_size=$((summary_size + size))
    ((idx += 1))
  done

  printf " done\n\n"
}

progress_bar() {
  local max_size=$1
  local current_size=$2
  local bar_length=$BAR_LENGTH

  local percent=0 filled_length=0 empty_length=$bar_length
  if ((max_size > 0)); then
    percent=$(((current_size * 100) / max_size))
    filled_length=$(((current_size * bar_length) / max_size))
    ((filled_length == 0 && current_size > 0)) && filled_length=1
    empty_length=$((bar_length - filled_length))
  fi

  local color=$COLOR_GREEN
  if ((percent >= 75)); then
    color=$COLOR_RED
  elif ((percent >= 50)); then
    color=$COLOR_YELLOW
  fi

  printf "[%b" "$color"
  printf '%*s' "$filled_length" '' | tr ' ' '#'
  printf "%b" "$COLOR_NONE"
  printf '%*s' "$empty_length" ''
  printf "]"
}

# --- Main -----------------------------------------------------------

# Gathers files and directories.
get_files
file_count=${#files[@]}
if ((file_count == 0)); then
  echo "No files or directories found."
  exit 0
fi

# Calculates the sizes of the files and directories.
calc_sizes

# Sorts the indices by size.
mapfile -t sorted_indices < <(
  for idx in "${!sizes[@]}"; do
    printf '%s\t%s\n' "${sizes[$idx]}" "$idx"
  done | sort -n | cut -f2
)

# Prints the results sorted by size.
for idx in "${sorted_indices[@]}"; do
  size="${sizes[$idx]}"
  size_str="${size_strs[$idx]}"
  name="${names[$idx]}"
  bar=$(progress_bar "$max_size" "$size")
  printf "%*s %s %s\n" "$max_size_str_len" "$size_str" "$bar" "$name"
done

# Prints the summary.
printf "\nTotal size: %s\n" "$(bytes_to_human "$summary_size")"
