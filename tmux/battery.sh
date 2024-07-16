#!/usr/bin/env bash

# Settings
DEBUG=false
show_text=1
show_ac_power=0

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
level_symbols3=""
level_symbols4="󰢟󰢜󰂆󰂇󰂈󰢝󰂉󰢞󰂊󰂋󰂅"

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
  [[ $show_ac_power -eq 1 ]] && echo "$cable_symbol"
  exit 0
elif [[ -z "$level" ]]; then
  echo "$unknown_symbol" && exit 0
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
    bp3=$(get_level_symbol "$i" "$level_symbols3")
    bp4=$(get_level_symbol "$i" "$level_symbols4")
    bp5=$(get_level_symbol "$i" "$charging_symbol_full")
    printf "%3d%% %s%s %s %s %s\n" "$i" "$bp1" "$bp2" "$bp3" "$bp4" "$bp5"
  done
fi

# Sets output
output=$(get_level_symbol "$level" "$level_symbols1")
[[ $has_ac_power == "AC Power" ]] && output="$charging_symbol$output"
[[ $show_text -eq 1 ]] && output="${output}${level}%"

echo "${output}"
