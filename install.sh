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
showOptions
askToStart

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
  #useBash
  useTmux
  useFd
  useVim
  useNeovim
  useKitty
  useLazygit
  httpie
fi

echo ""
info "Finished"