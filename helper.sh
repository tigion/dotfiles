#!/usr/bin/env bash

# colors
COLOR_GRAY="\033[0;38;5;243m"
COLOR_BLUE="\033[0;34m"
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_NONE="\033[0m"

# outputs
title() {
  printf "\n%b[%b == %b]%b %b%b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_BLUE" "$1" "$COLOR_NONE"
}
subtitle() {
  printf "\n%b[%b -- %b]%b %b%b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_BLUE" "$1" "$COLOR_NONE"
}
info() {
  printf "%b[%b .. %b]%b %b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
question() {
  printf "\n%b[%b ?? %b]%b %b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
success() {
  printf "%b[%b OK %b]%b %b\n" "$COLOR_GRAY" "$COLOR_GREEN" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
warning() {
  printf "%b[%bWARN%b]%b %b\n" "$COLOR_GRAY" "$COLOR_YELLOW" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
skip() {
  printf "%b[%bSKIP%b]%b %b\n" "$COLOR_GRAY" "$COLOR_YELLOW" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
fail() {
  printf "%b[%bFAIL%b]%b %b\n" "$COLOR_GRAY" "$COLOR_RED" "$COLOR_GRAY" "$COLOR_NONE" "$1"
  exit 1
}

# check if not dry-run
is_active() {
  [[ "$OPTION_DRYRUN" == "true" ]] && printf "%b!%b" "$COLOR_YELLOW" "$COLOR_NONE"
  [[ "$OPTION_DRYRUN" != "true" ]]
}

# check OS
is_linux() {
  [[ $(uname -s) == "Linux" ]]
}
is_macos() {
  [[ $(uname -s) == "Darvin" ]]
}
# is_windows_wsl() {
#   # TODO
# }

# get true/false as yes/no
get_yes_no() {
  local yes="${COLOR_GREEN}Yes${COLOR_NONE}"
  local no="${COLOR_RED}No${COLOR_NONE}"
  if [[ "$1" == "true" ]]; then echo "$yes"; else echo "$no"; fi
}

# check if a command exists
is_command() {
  command -v "$1" &>/dev/null
}

# ready to start
ask_to_start() {
  question "Ready to start (y/n)?"
  read -r -n 1 answer
  printf "\r"
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    info "Bye"
    exit 0
  fi
  info "$answer"
}
