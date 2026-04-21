#!/usr/bin/env bash

set -euo pipefail

# =========================
# Config / Globals
# =========================

# Config
SIZE_MODE="blocks" # Uses "du" for block sizes (faster).
case "${1:-}" in
  --exact) SIZE_MODE="exact" ;; # Uses "stat" for exact sizes (slower).
  "") ;;                        # No argument, uses default "blocks" mode.
  *)
    echo "Usage: $(basename "$0") [--exact]" >&2
    exit 1
    ;;
esac
BAR_LENGTH=10

# Colors
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_NONE="\033[0m"

# OS detection
case "$(uname -s)" in
  Linux) OS_NAME="Linux" ;;
  Darwin) OS_NAME="macOS" ;;
  *) OS_NAME="Unknown" ;;
esac

# Global data variables
files=()
sizes=()
size_strs=()
names=()
max_size=0
max_size_str_len=0

# =========================
# Functions
# =========================

source "$HOME/lib/convert.sh" || exit 1

get_files() {
  shopt -s nullglob dotglob
  files=(*)
  shopt -u nullglob dotglob
}

get_size_with_du() {
  local file=$1
  local size=0
  # Handles possible newlines in filenames safely.
  size=$(du -sk -- "$file" 2>/dev/null | awk 'NR==1 {print $1}')
  # Converts the size from kilobytes to bytes.
  echo "$((size * 1024))"
}

get_size_with_stat() {
  local file=$1
  local size=0

  if [[ -f "$file" ]]; then
    case "$OS_NAME" in
      Linux) size=$(stat -c%s -- "$file") ;;
      macOS) size=$(stat -f%z -- "$file") ;;
    esac
  elif [[ -d "$file" ]]; then
    size=$(get_dir_size "$file")
  fi

  echo "$size"
}

get_dir_size() {
  local dir=$1
  local file
  local size=0 total_size=0

  cd -- "$dir" || exit 0
  shopt -s nullglob dotglob
  local files=(*)
  shopt -u nullglob dotglob

  for file in "${files[@]}"; do
    if [[ -L "$file" ]]; then
      # Skips symbolic links to avoid potential infinite loops.
      continue
    elif [[ -f "$file" ]]; then
      case "$OS_NAME" in
        Linux) size=$(stat -c%s -- "$file") ;;
        macOS) size=$(stat -f%z -- "$file") ;;
      esac
      total_size=$((total_size + size))
    elif [[ -d "$file" ]]; then
      size=$(get_dir_size "$file")
      total_size=$((total_size + size))
    fi
  done

  echo "$total_size"
}

calc_sizes() {
  local idx=0
  local file size size_str size_str_len name

  for file in "${files[@]}"; do
    printf '\rCalculating (%s): %s/%s ...' "$SIZE_MODE" "$((idx + 1))" "$count"

    # Skips if the file does not exist.
    [[ -e "$file" ]] || continue

    # Gets the size of the file or directory.
    case "$SIZE_MODE" in
      exact) size=$(get_size_with_stat "$file") ;;
      blocks) size=$(get_size_with_du "$file") ;;
    esac

    ((size > max_size)) && max_size=$size
    size_str=$(convert "$size")
    size_str_len=${#size_str}
    ((size_str_len > max_size_str_len)) && max_size_str_len=$size_str_len

    # Escapes the file name for safe printing.
    name=$(printf '%q' "$file")
    [[ -d "$file" ]] && name="${name}/"

    sizes[idx]=$size
    size_strs[idx]=$size_str
    names[idx]=$name

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

# =========================
# Main
# =========================

# Gathers files and directories.
get_files
count=${#files[@]}
if ((count == 0)); then
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
