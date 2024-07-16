#!/usr/bin/env bash

# Settings
DEBUG=false
show_text=true
show_text_warning=50
show_ac_power=false

# Options
while :; do
  case "$1" in
  --debug) DEBUG=true ;;
  *) break ;;
  esac
  shift
done

# Symbols
unknown_symbol="󰂑"
cable_symbol=""
charging_symbol=""
charging_symbol_full="󰂄"
level_symbols1="󰂎󱊡󱊢󱊣"
level_symbols2="󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"

# Get battery level in percentage
level=""
if [[ $(uname -s) == "Darwin" ]]; then
  # macOS `pmset -g batt`
  #
  # Now drawing from 'AC Power'
  #
  # Now drawing from 'AC Power'
  # -InternalBattery-0 (id=1234567)    96%; charged; 0:00 remaining present: true
  #
  # Now drawing from 'Battery Power'
  # -InternalBattery-0 (id=1234567)    97%; discharging; 4:56 remaining present: true
  has_ac_power=$(pmset -g batt | grep -Eo "AC Power")
  # has_battery_power=$(pmset -g batt | grep -Eo "Battery Power")
  has_battery=$(pmset -g batt | grep -Eo "InternalBattery")
  level=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
fi

# Checks if we have battery or battery level
if [[ -z "$has_battery" ]]; then
  [[ $show_ac_power == true ]] && echo "$cable_symbol"
  exit 0
elif [[ -z "$level" ]]; then
  echo "$unknown_symbol" && exit 0
elif [[ "$level" -eq 100 ]]; then
  echo "$charging_symbol_full" && exit 0
fi

# Gets battery level symbol
# - $1: battery level
# - $2: battery level symbols
function get_level_symbol() {
  level=$(($1 > 100 ? 100 : $1 < 0 ? 0 : $1))
  [[ -z $2 ]] && symbols="$level_symbols1" || symbols="$2"
  steps=$((${#symbols} - 1))
  idx=0
  if [[ $steps -gt 0 ]]; then
    idx=$(((level + (100 / (2 * steps)) - 1) / (100 / steps)))
    idx=$((idx > steps ? steps : (idx < 0 ? 0 : idx)))
  fi
  echo "${symbols:$idx:1}"
}

# Test output
if [[ $DEBUG == "true" ]]; then
  for i in $(seq 0 1 100); do
    bp1=$(get_level_symbol "$i" "$level_symbols1")
    bp2=$(get_level_symbol "$i" "$level_symbols2")
    printf "%3d%% %s %s\n" "$i" "$bp1" "$bp2"
  done
fi

# Sets output
output=$(get_level_symbol "$level" "$level_symbols1")
[[ $has_ac_power == "AC Power" ]] && output="${charging_symbol}${output}"
[[ $show_text == true || $level -le $show_text_warning ]] && output="${output}${level}%"

echo "$output"
