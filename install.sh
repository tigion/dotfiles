#!/usr/bin/env bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# use absolute paths
DOTFILES_ROOT="$(pwd)"

# option defaults
INSTALL_SOFTWARE=false
INSTALL_CONFIG=true
OVERWRITE_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG_LINK=false
SKIP_EXISTING_CONFIG=true
OPTION_DRYRUN=false

# handle command-line options
while :; do
  case "$1" in
    --software) INSTALL_SOFTWARE=true ;;
    --no-software) INSTALL_SOFTWARE=false ;;
    --config) INSTALL_CONFIG=true ;;
    --no-config) INSTALL_CONFIG=false ;;
    --overwrite) OVERWRITE_EXISTING_CONFIG=true ;;
    --no-overwrite) OVERWRITE_EXISTING_CONFIG=false ;;
    --backup) BACKUP_EXISTING_CONFIG=true ;;
    --no-backup) BACKUP_EXISTING_CONFIG=false ;;
    --dry-run) OPTION_DRYRUN=true ;;
    *) break ;;
  esac
  shift
done

# parameters
BACKUP_TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"

# Exit immediately if a command returns a non-zero status
set -e

# load helper functions
source "${DOTFILES_ROOT}/helper.sh"
source "${DOTFILES_ROOT}/helper_install.sh"

# start
title "Start installation"
show_options
check_supported_systems
ask_to_start

# install software
if [[ "$INSTALL_SOFTWARE" == "true" ]]; then
  title "Install Software"
  is_macos && install_xcode_cli
  is_ubuntu && install_via_apt
  is_ubuntu && install_via_snap
  install_via_homebrew
fi

# link configs and install dependencies
if [[ "$INSTALL_CONFIG" == "true" ]]; then
  title "Install Configurations"
  link_scripts
  # use_bash
  use_btop
  use_fastfetch
  use_fd
  use_fzf
  use_ghostty
  use_git
  use_httpie
  use_kitty
  use_lazygit
  use_neovim
  use_ssh
  use_tmux
  use_vim
  use_zsh
fi

echo ""
info "Finished"
