#!/usr/bin/env bash

# Converts kilobytes to human-readable format.
convert() {
  local value=$1
  local result=$value unit="K"

  # Converts the value and sets the unit.
  if ((value >= 1024 * 1024 * 1024)); then
    result=$(echo "scale=2; $value / (1024 * 1024 * 1024)" | bc) unit="T"
  elif ((value >= 1024 * 1024)); then
    result=$(echo "scale=2; $value / (1024 * 1024)" | bc) unit="G"
  elif ((value >= 1024)); then
    result=$(echo "scale=2; $value / 1024" | bc) unit="M"
  elif ((value == 0)); then
    result=0 unit="B"
  fi

  # Prints the result rounded to one decimal place.
  #
  # NOTE: `LC_NUMERIC=C` ensures that the decimal separator is a dot.
  #       This prevents the error `printf: invalid number` in locales
  #       such as `de_DE.UTF-8` that use a comma as decimal separator.
  #
  LC_NUMERIC=C printf "%.1f%s" "$result" "$unit"
}
