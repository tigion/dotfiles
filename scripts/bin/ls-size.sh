#!/usr/bin/env bash

# This script lists files and directories in the current
# directory sorted by their size.

# Loads the needed functions.
source "$HOME/lib/convert.sh" || exit 1

# Colors
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_NONE="\033[0m"

# Build list of file and directory entries into global array `files`.
#
# Notes:
#   Uses Bash globbing with:
#     - nullglob: avoids literal unmatched patterns
#     - dotglob: includes hidden files (except `.` and `..`)
get_files() {
  # files=(.[!.]* *)
  shopt -s nullglob dotglob
  files=(*)
  shopt -u nullglob dotglob
}

# Generates a progress bar.
progress_bar() {
  local max_size=$1
  local current_size=$2
  local bar_length=10

  local filled_length=0 percent=0
  if ((max_size > 0)); then
    filled_length=$(((current_size * bar_length) / max_size))
    filled_length=$((filled_length == 0 && current_size > 0 ? 1 : filled_length))
    percent=$(((current_size * 100) / max_size))
  fi
  local empty_length=$((bar_length - filled_length))

  local color=$COLOR_GREEN
  if ((percent >= 75)); then
    color=$COLOR_RED
  elif ((percent >= 50)); then
    color=$COLOR_YELLOW
  fi

  printf "[%b" "$color"
  for ((i = 0; i < filled_length; i++)); do printf "#"; done
  printf "%b" "$COLOR_NONE"
  for ((i = 0; i < empty_length; i++)); do printf " "; done
  printf "]"
}

# Gathers files and directories.
get_files
count=${#files[*]}
if ((count == 0)); then
  echo "No files or directories found."
  exit 0
fi

# Calculates the sizes.
idx=0
sizes=() size_strs=() names=()
max_size=0 max_size_str_len=0
for file in "${files[@]}"; do
  printf '\rCalculating: %s/%s ...' "$((idx + 1))" "$count"

  # Skips if the file does not exist.
  [[ -e $file ]] || continue

  # Handles possible newlines in filenames safely.
  size=$(du -sk -- "$file" 2>/dev/null | awk 'NR==1 {print $1}')

  ((size > max_size)) && max_size=$size
  size_str=$(convert "$size")
  size_str_len=${#size_str}
  ((size_str_len > max_size_str_len)) && max_size_str_len=$size_str_len

  # Escapes the file name for safe printing.
  name=$(printf '%q\n' "$file")
  [[ -d "$file" ]] && name="$name/"

  sizes[idx]=$size
  size_strs[idx]=$size_str
  names[idx]=$name

  ((idx++))
done
printf " done\n\n"

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
  bar=$(progress_bar "$max_size" "$size")
  name="${names[$idx]}"
  printf "%*s %s %s\n" "$max_size_str_len" "$size_str" "$bar" "$name"
done
