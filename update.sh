#!/usr/bin/env bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# Use absolute paths
DOTFILES_ROOT="$(pwd)"

# Option defaults
INSTALL_UPDATES=false
CLEAN_UP=true

# Show usage information
usage() {
  echo "Usage: $0 [-i|--install] [-h|--help]"
  echo "  -h, --help     Show this help message and exit"
  echo "  -i, --install  Install updates"
}

# Handle command-line options
while test $# -gt 0; do
  case "$1" in
    -h | --help)
      usage
      exit
      ;;
    -i | --install) INSTALL_UPDATES=true ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
  shift
done

# Exit immediately if a command returns a non-zero status
set -e

# Load helper functions
source "${DOTFILES_ROOT}/helper.sh"
source "${DOTFILES_ROOT}/helper_update.sh"

# Start
title "Start update"
show_options
ask_to_start

is_ubuntu && update_apt
update_homebrew
is_macos && update_ruby
update_node
# update_python
