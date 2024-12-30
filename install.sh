#!/bin/bash

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

# start
title "Start installation"
show_options
ask_to_start

# install software
if [[ "$INSTALL_SOFTWARE" == "true" ]]; then
  title "Install Software"
  install_xcode_cli
  install_homebrew
fi

# link configs and install dependencies
if [[ "$INSTALL_CONFIG" == "true" ]]; then
  title "Install Configurations"
  use_bin
  use_git
  use_ssh
  use_zsh
  #use_bash
  use_tmux
  use_fd
  use_vim
  use_neovim
  use_kitty
  use_lazygit
  use_httpie
  use_fzf
  use_ghostty
  use_btop
  use_fastfetch
fi

echo ""
info "Finished"
