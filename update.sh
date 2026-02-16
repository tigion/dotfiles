#!/usr/bin/env bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# Use absolute paths
DOTFILES_ROOT="$(pwd)"

# Option defaults
INSTALL_UPDATES=false
CLEAN_UP=true
UPDATE_HOMEBREW=true
UPDATE_APT=false
UPDATE_RUBY=false
UPDATE_NODE=false

# Show usage information
usage() {
  echo "Usage: $0 [-i|--install] [-h|--help]"
  echo "  -h, --help     Show this help message and exit"
  echo "  -i, --install  Install updates"
  echo "      --ruby     Update global Ruby gems"
  echo "      --node     Update global Node packages"
  echo "      --all      Update all package managers"
}

# Handle command-line options
while test $# -gt 0; do
  case "$1" in
    -h | --help)
      usage
      exit
      ;;
    -i | --install) INSTALL_UPDATES=true ;;
    --ruby) UPDATE_RUBY=true ;;
    --node) UPDATE_NODE=true ;;
    --all)
      UPDATE_RUBY=true
      UPDATE_NODE=true
      ;;
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

# Set update options based on OS
if is_ubuntu; then UPDATE_APT=true; fi
if ! is_macos; then UPDATE_HOMEBREW=false; fi

# Start
title "Start update"
show_options
check_supported_systems
ask_to_start

[[ "$UPDATE_APT" == "true" ]] && update_apt
[[ "$UPDATE_HOMEBREW" == "true" ]] && update_homebrew
[[ "$UPDATE_RUBY" == "true" ]] && is_macos && update_ruby
[[ "$UPDATE_NODE" == "true" ]] && update_node
