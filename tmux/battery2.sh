#!/usr/bin/env bash

# Get battery values
has_battery=false
battery_level=""
is_charging=false
if [[ $(uname -s) == "Darwin" ]]; then
  pmset -g batt | grep -qE "InternalBattery" && has_battery=true
  if $has_battery; then
    battery_level=$(pmset -g batt | grep -oE "\d+%" | cut -d% -f1)
    pmset -g batt | grep -qE " charging" && is_charging=true
  fi
fi

# Checks if we have a battery
! $has_battery && exit 0
# Checks if we habe a battery level
[[ -z $battery_level ]] && echo "󰂑" && exit 0
# Checks if we have a full battery and charging
[[ $battery_level -gt 100 ]] && $is_charging && echo "󰂄" && exit 0

# Sets output
output="󰂎"
if [[ $battery_level -gt 83 ]]; then
  output="󱊣"
elif [[ $battery_level -gt 49 ]]; then
  output="󱊢"
elif [[ $battery_level -gt 16 ]]; then
  output="󱊡"
fi
$is_charging && output="${output}"
[[ $battery_level -le 50 ]] && output="${output} ${battery_level}%"

echo "$output"
