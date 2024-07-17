#!/usr/bin/env bash

# Settings
# If true, shows text with battery level in percentage.
show_text=false
# If true, shows the text if battery level is less or
# equal than the given threshold value.
show_text_warning=true
# Threshold value in percentage to show text.
show_text_warning_value=50
# If true, shows an AC connection symbol if there is no battery.
# If false, shows nothing.
show_ac_power=false
# If true, prints debug info.
DEBUG=false

# Parse options
while :; do
  case "$1" in
    --debug) DEBUG=true ;;
    *) break ;;
  esac
  shift
done

# Symbols
cable_symbol=""
unknown_symbol="󰂑"
charging_symbol=""
charging_symbol_full="󰂄"
level_symbols1="󰂎󱊡󱊢󱊣"
level_symbols2="󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"

# Get battery values
has_battery=false
battery_level=""
is_charging=false
if [[ $(uname -s) == "Darwin" ]]; then
  # pmset -g batt
  pmset -g batt | grep -qE "InternalBattery" && has_battery=true
  if $has_battery; then
    battery_level=$(pmset -g batt | grep -oE "\d+%" | cut -d% -f1)
    pmset -g batt | grep -qE " charging" && is_charging=true
  fi
elif [[ $(uname -s) == "Linux" ]]; then
  # https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-power
  grep -qE "1" 2>/dev/null </sys/class/power_supply/BAT0/present && has_battery=true
  if $has_battery; then
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    grep -qE "^Charging" 2>/dev/null </sys/class/power_supply/BAT0/status && is_charging=true
  fi
fi

# Checks if we have a battery
if ! $has_battery; then
  $show_ac_power && echo "$cable_symbol"
  exit 0
fi

# Checks if we have a battery level
[[ -z $battery_level ]] && echo "$unknown_symbol" && exit 0

# Checks if we have a full battery and charging
[[ $battery_level -gt 100 ]] && $is_charging && echo "$charging_symbol_full" && exit 0

# Gets battery level symbol
# - $1: battery level
# - $2: battery level symbols
function get_level_symbol() {
  battery_level=$(($1 > 100 ? 100 : $1 < 0 ? 0 : $1))
  [[ -z $2 ]] && symbols="$level_symbols1" || symbols="$2"
  steps=$((${#symbols} - 1))
  idx=0
  if [[ $steps -gt 0 ]]; then
    idx=$(((battery_level + (100 / (2 * steps)) - 1) / (100 / steps)))
    idx=$((idx > steps ? steps : (idx < 0 ? 0 : idx)))
  fi
  echo "${symbols:$idx:1}"
}

# Test output
if $DEBUG; then
  for i in $(seq 0 1 100); do
    bp1=$(get_level_symbol "$i" "$level_symbols1")
    bp2=$(get_level_symbol "$i" "$level_symbols2")
    printf "%3d%% %s %s\n" "$i" "$bp1" "$bp2"
  done
fi

# Sets output
output=$(get_level_symbol "$battery_level" "$level_symbols1")
$is_charging && output="${charging_symbol}${output}"
! $show_text && $show_text_warning && [[ $battery_level -le $show_text_warning_value ]] && show_text=true
$show_text && output="${output} ${battery_level}%"

echo "$output"
