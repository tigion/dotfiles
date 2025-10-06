#!/usr/bin/env bash

temp=""

if [[ $(uname -s) == "Linux" ]]; then
  file=/sys/class/thermal/thermal_zone0/temp
  if [[ -f "$file" ]]; then
    temp=$(echo "scale=0; $(cat "$file") / 1000" | bc)
  fi
fi

[[ -n "$temp" ]] && echo "${temp}°C"
