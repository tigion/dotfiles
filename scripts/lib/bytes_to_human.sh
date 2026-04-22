# vim: set filetype=bash:

readonly _KiB=1024
readonly _MiB=$((_KiB * _KiB))
readonly _GiB=$((_MiB * _KiB))
readonly _TiB=$((_GiB * _KiB))

# Converts a value in bytes to a human-readable format.
# Rounds to one decimal place using round-half-up.
# Parameters:
#  $1: value in bytes
bytes_to_human() {
  local value="${1:-0}"
  if [[ ! "$value" =~ ^[0-9]+$ ]]; then
    echo "Error: Value must be a non-negative integer." >&2
    return 1
  fi

  local precision_digits=1
  local precision_factor=$((10 ** precision_digits))

  local divisor=1 unit="B"
  if ((value >= _TiB)); then
    divisor=$_TiB unit="T"
  elif ((value >= _GiB)); then
    divisor=$_GiB unit="G"
  elif ((value >= _MiB)); then
    divisor=$_MiB unit="M"
  elif ((value >= _KiB)); then
    divisor=$_KiB unit="K"
  fi

  # Scale the value to preserve decimal precision and divide by the unit size.
  # Adding `divisor / 2` ensures correct rounding instead of truncation.
  local result=$(((value * precision_factor + divisor / 2) / divisor))

  local int_part=$((result / precision_factor))
  local dec_part=$((result % precision_factor))

  printf "%d.%0*d%s\n" "$int_part" "$precision_digits" "$dec_part" "$unit"
}
