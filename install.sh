#!/bin/bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# use absolute paths
DOTFILES_ROOT="$(pwd)"

# options
# TODO: use command line options
INSTALL_SOFTWARE=false
INSTALL_CONFIG=true
OVERWRITE_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG_LINK=false
SKIP_EXISTING_CONFIG=true
OPTION_DRYRUN=false

# check dry run
if [[ "$1" == "--dry-run" ]]; then
  OPTION_DRYRUN=true
fi

# parameters
BACKUP_TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"

# Exit immediately if a command returns a non-zero status
set -e

# load helper functions
source "${DOTFILES_ROOT}/helper.sh"

# start
title "Start installation"
showOptions
readyToStart

# install software
if [[ "$INSTALL_SOFTWARE" == "true" ]]; then
  title "Install Software"
  installXcodeCommandLineTools
  installHomebrew
fi

# link configs and install dependies
if [[ "$INSTALL_CONFIG" == "true" ]]; then
  title "Install Configurations"
  useBin
  useGit
  useSsh
  useZsh
  useBash
  useFd
  useVim
  useNeovim
  useKitty
  useLazygit
fi

info "Finished"
