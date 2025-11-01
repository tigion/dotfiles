#!/usr/bin/env bash

# This script lists files and directories in the current
# directory sorted by their size.

# Loads the needed functions.
source "$HOME/lib/convert.sh"

# Colors
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_NONE="\033[0m"

# Generates a progress bar.
progress_bar() {
  max_size=$1
  current_size=$2
  bar_length=10

  filled_length=$(( (current_size * bar_length) / max_size ))
  filled_length=$(( filled_length == 0 && current_size > 0 ? 1 : filled_length ))
  empty_length=$(( bar_length - filled_length ))

  percent=$(( (current_size * 100) / max_size ))

  color=$COLOR_GREEN
  if ((percent >= 75)); then
    color=$COLOR_RED
  elif ((percent >= 50)); then
    color=$COLOR_YELLOW
  fi

  printf "[%b" "$color"
  for ((i=0; i<filled_length; i++)); do printf "#"; done
  printf "%b" "$COLOR_NONE"
  for ((i=0; i<empty_length; i++)); do printf " "; done
  printf "]"
}

# Gathers files and directories.
files=(.[!.]* *)
count=${#files[*]}

# Calculates sizes.
results=() max_size=0 max_size_str=0 i=0
for file in "${files[@]}"; do
  printf "\rCalculating: %s/%s ..." "$((i + 1))" "$count"
  result=$(du -sk "$file" 2>/dev/null)
  [[ -d "$file" ]] && result="$result/"
  results[i]=$result
  size=$(echo "$result" | cut -f1)
  ((size > max_size)) && max_size=$size
  size_str=$(convert "$size"); size_str=${#size_str}
  ((size_str > max_size_str)) && max_size_str=$size_str
  ((i++))
done
printf " done\n\n"

# Prints the results sorted by size.
IFS_SAVE=$IFS && IFS=$'\n'
for entry in $(printf '%s\n' "${results[@]}" | sort -h); do
  size=$(echo "$entry" | cut -f1)
  fname=$(echo "$entry" | cut -f2-)
  # Prints the info line.
  printf "%*s %s %s\n" "$max_size_str" "$(convert "$size")" "$(progress_bar "$max_size" "$size")" "$fname"
done
IFS=$IFS_SAVE
