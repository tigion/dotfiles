#!/usr/bin/env bash

# This scripts shows the disk quota usage information
# for the user's volumes.

# Exits if no quota command is available or the '--no-wrap'
# option is not supported.
if ! command -v quota &>/dev/null; then
  echo "The 'quota' command was not found."
  exit 1
elif ! quota --no-wrap >/dev/null 2>&1; then
  echo "The script needs a 'quota' command with support for the '--no-wrap' option."
  exit 1
fi

# Loads the needed functions.
source "$HOME/lib/convert.sh"

# Colors
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_NONE="\033[0m"

# Displays usage information and an usage bar with used and soft/hard limit.
show_usage_info() {
  local volume=$1
  local used_p=$2
  local warn_p=$3
  local soft_p=$4
  local free_str=$5
  local hard_str=$6

  # Uses the color based on usage.
  local color="$COLOR_GREEN"
  if ((used_p >= soft_p)); then color="$COLOR_RED"; elif ((used_p >= warn_p)); then color="$COLOR_YELLOW"; fi

  # Calculates the bar widths.
  local start_part end_part
  start_part=$(printf "%b%9s%b: %3s%% [" "$color" "$volume" "$COLOR_NONE" "$used_p")
  end_part=$(printf "] %7s of %7s free" "$free_str" "$hard_str")
  bar_width=$(($(tput cols) - ${#start_part} - ${#end_part} + 11)) # 11 is for the included color codes.
  used_width=$((used_p * bar_width / 100))

  # Prints the usage info.
  printf "%s" "$start_part"
  for ((i = 0; i < bar_width; i++)); do
    if ((i <= used_width)); then printf "%b#%b" "$color" "$COLOR_NONE"; else printf "-"; fi
  done
  printf "%s\n" "$end_part"
}

# Gets the quota information for the userdata volume.
source=$(quota --no-wrap | tail -n +3)

# Exits if no quota information is available.
if [[ -z "$source" ]]; then
  echo "No quota information available."
  exit 1
fi

printf "Quota Usage Information:\n"

IFS_SAVE=$IFS
IFS=$'\n' # set the Internal Field Separator to newline
for str in $source; do
  # Extracts the volume name.
  volume=$(echo "$str" | tr -s ' ' | cut -d' ' -f1 | cut -d'_' -f5)

  # Extracts the used and soft/hard quota values.
  used=$(echo "$str" | tr -s ' ' | cut -d' ' -f2)
  soft=$(echo "$str" | tr -s ' ' | cut -d' ' -f3)
  hard=$(echo "$str" | tr -s ' ' | cut -d' ' -f4)

  # Calculates free space and percentages.
  free=$((hard - used))
  used_p=$((used * 100 / hard))
  soft_p=$((soft * 100 / hard))
  warn_p=80

  # Shows the quota usage information.
  show_usage_info "$volume" "$used_p" "$warn_p" "$soft_p" "$(convert "$free")" "$(convert "$hard")"
done
IFS=$IFS_SAVE # restore the original IFS
