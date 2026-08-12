#!/usr/bin/env bash

cd -- "$(dirname -- "$0")" || exit 1

separator="  "

cpu_temp="$(./cpu_temp.sh)"
battery="$(./battery.sh)"

parts=()

[[ -n "$cpu_temp" ]] && parts+=("$cpu_temp")
[[ -n "$battery" ]] && parts+=("$battery")

if ((${#parts[@]})); then
  output=""
  for part in "${parts[@]}"; do
    output+="${part}${separator}"
  done
  printf '%s\n' "$output"
fi
