#!/usr/bin/env bash

temp=""

os=$(uname -s)

case "$os" in
  Darwin)
    if command -v macmon >/dev/null 2>&1; then
      json="$(macmon pipe -s 1 -i 100)"
      temp="${json#*\"cpu_temp_avg\":}"
      temp="${temp%%,*}"
    fi
    ;;

  Linux)
    for zone in /sys/class/thermal/thermal_zone*/; do
      [[ -r "$zone/type" && -r "$zone/temp" ]] || continue

      case "$(<"$zone/type")" in
        x86_pkg_temp | cpu-thermal | cpu_thermal)
          temp=$(<"$zone/temp")
          temp=$((temp / 1000))
          break
          ;;
      esac
    done
    # file=/sys/class/thermal/thermal_zone1/temp
    #
    # if [[ -f "$file" ]]; then
    #   temp=$(<"$file")
    #   temp=$((temp / 1000))
    # fi
    ;;
esac

[[ -n "$temp" ]] && printf '%.0f°C\n' "$temp"
