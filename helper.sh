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
  [[ $OSTYPE == linux-gnu* ]]
}
is_macos() {
  [[ $OSTYPE == darwin* ]]
}
is_ubuntu() {
  # [[ "$(uname -a)" == *"Ubuntu"* ]]
  local file="/etc/os-release"
  [[ ! -f "$file" ]] && return 1
  # shellcheck source=/dev/null
  source "$file"
  [[ "$ID" == "ubuntu" ]]
}

# get true/false as yes/no
get_yes_no() {
  local yes="${COLOR_GREEN}Yes${COLOR_NONE}"
  local no="${COLOR_RED}No${COLOR_NONE}"
  if [[ "$1" == "true" ]]; then echo "$yes"; else echo "$no"; fi
}

# check if a command exists
is_command() {
  command -v "$1" &>/dev/null
  # command -v "$1" >/dev/null 2>&1
}

# check supported operating systems
check_supported_systems() {
  subtitle "Supported Operating Systems:"
  local is_macos is_ubuntu
  is_macos=$(is_macos && echo true || echo false)
  is_ubuntu=$(is_ubuntu && echo true || echo false)
  info "Found macOS: $(get_yes_no "$is_macos")"
  info "Found Ubuntu Linux: $(get_yes_no "$is_ubuntu")"
  if [[ "$is_macos" != "true" && "$is_ubuntu" != "true" ]]; then
    fail "No supported Operating System found!"
  fi
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
