#!/usr/bin/env bash

# Settings
show_percentage=0
show_low_warning=1
low_warning_threshold=25
show_ac_power=0
debug=0

# Symbols
ac_power=""
unknown="󰂑"
charging=""
ac_full="󰂄"
# Level symbols (coarse and fine)
levels_coarse=("󰂎" "󱊡" "󱊢" "󱊣")
levels_fine=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
levels_active=("${levels_coarse[@]}") # Use coarse levels by default.

# Battery status
has_ac_power=0
has_battery=0
is_charging=0
battery_level=-1

usage() {
  printf 'Usage: %s [--style-fine] [--debug] [--help]\n' "${0##*/}"
}

validate_battery_level() {
  local level=$1

  # Validate battery level is an unsigned number.
  if [[ ! $level =~ ^[0-9]+$ ]]; then
    level=-1
  else
    # Force base 10 to tolerate leading zeros.
    level=$((10#$level))

    # Clamp level to 0-100 range
    level=$((level > 100 ? 100 : level < 0 ? 0 : level))
  fi

  printf '%d' "$level"
}

read_battery_darwin() {
  local report
  report=$(pmset -g batt 2>/dev/null) || return 0

  [[ $report == *"'AC Power'"* ]] && has_ac_power=1
  [[ $report == *InternalBattery* ]] && has_battery=1

  ((has_battery)) || return 0

  [[ $report =~ ([0-9]+)% ]] && battery_level=${BASH_REMATCH[1]}
  battery_level=$(validate_battery_level "$battery_level")
  [[ $report == *"; charging"* || $report == *"; finishing charge"* ]] && is_charging=1
}

read_battery_linux() {
  # https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-power

  # TODO: Needs testing and more flexibility (AC, Bat0).

  local supply_ac="/sys/class/power_supply/AC"
  if [[ -d "$supply_ac" && -r "$supply_ac/online" ]]; then
    [[ $(<"$supply_ac/online") == "1" ]] && has_ac_power=1
  fi

  local supply_bat="/sys/class/power_supply/BAT0"
  if [[ -d "$supply_bat" && -r "$supply_bat/type" ]]; then
    [[ $(<"$supply_bat/type") == "Battery" ]] && has_battery=1
  fi

  ((has_battery)) || return 0

  [[ -r "$supply_bat/capacity" ]] && battery_level=$(<"$supply_bat/capacity")
  battery_level=$(validate_battery_level "$battery_level")
  [[ -r "$supply_bat/status" && $(<"$supply_bat/status") == "Charging" ]] && is_charging=1
}

symbol_index() {
  local level=$1
  local count=$2

  level=$((level > 100 ? 100 : level < 0 ? 0 : level))

  local idx=$(((level * (count - 1) + 49) / 100))

  printf '%d' "$idx"
}

get_level_symbol() {
  local level=$1
  local idx

  idx=$(symbol_index "$level" "${#levels_active[@]}")

  printf '%s' "${levels_active[idx]}"
}

print_debug_info() {
  printf '%s\n' 'Battery status:'
  printf '  has_battery:   %d\n' "$has_battery"
  printf '  has_ac_power:  %d\n' "$has_ac_power"
  printf '  battery_level: %d\n' "$battery_level"
  printf '  is_charging:   %d\n' "$is_charging"

  printf '\n%s\n' 'Symbols:'
  printf '  symbols:       %s %s %s %s\n' \
    "$ac_power" "$unknown" "$charging" "$ac_full"
  printf '  levels_coarse: %s\n' "${levels_coarse[*]}"
  printf '  levels_fine:   %s\n' "${levels_fine[*]}"

  printf '\n%s\n' 'Level symbols:'
  local level
  for ((level = 0; level <= 100; level += 10)); do
    local idx_coarse idx_fine
    idx_coarse=$(symbol_index "$level" "${#levels_coarse[@]}")
    idx_fine=$(symbol_index "$level" "${#levels_fine[@]}")
    printf '  %3d%% %s [%2d] %s [%2d]\n' \
      "$level" \
      "${levels_coarse[$idx_coarse]}" "$idx_coarse" \
      "${levels_fine[$idx_fine]}" "$idx_fine"
  done

  printf '\n'
}

# Parse options
while (($#)); do
  case "$1" in
    --style-fine)
      levels_active=("${levels_fine[@]}")
      ;;
    --debug) debug=1 ;;
    --help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

# Read battery info
case "$(uname -s)" in
  Darwin) read_battery_darwin ;;
  Linux) read_battery_linux ;;
esac

# Print debug info if requested
((debug)) && print_debug_info

# Handle systems without a battery as AC power only
if ((!has_battery)); then
  ((show_ac_power)) && printf '%s\n' "$ac_power"
  exit 0
fi

# Handle unknown battery level
if ((battery_level == -1)); then
  echo "$unknown"
  exit 0
fi

# Handle full battery with AC power and not charging
if ((battery_level >= 100 && has_ac_power && !is_charging)); then
  printf '%s\n' "$ac_full"
  exit 0
fi

# Sets output
output=$(get_level_symbol "$battery_level")

((is_charging)) && output="${charging}${output}"

if ((!show_percentage && show_low_warning && battery_level <= low_warning_threshold)); then
  show_percentage=1
fi

((show_percentage)) && output+=" ${battery_level}%"

printf '%s\n' "$output"
