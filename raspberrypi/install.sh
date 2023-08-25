#!/bin/bash
#
# Raspberry Pi 4 (Ubuntu Server) install script:
# - needed software, languages
# - load dotfiles
# - set zsh as default shell

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

#
TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"
install_folder="${HOME}/install_${TIMESTAMP}"

# exit immediately if a command returns a non-zero status
set -e

# load helper functions
source "helper.sh"

# create temporary install folder
mkdir "$install_folder" && cd "$install_folder" || exit

# start

# base
printf "\nInstall: git, zsh, tmux, mosh\n"
sudo apt install git zsh tmux mosh

# python
printf "\nInstall: python\n"
sudo apt install python3 python3-pip python3-venv

# php
printf "\nInstall: php\n"
sudo apt install php composer php-xml

# lazygit
printf "\nInstall: lazygit\n"
install_lazygit

# neovim + needed tools
printf "\nInstall: neovim tools\n"
install_neovim_tools
printf "\nInstall: neovim\n"
install_neovim

# dotfiles
printf "\nInstall: dotfiles\n"
dotfiles_folder="$HOME/dotfiles"
if [[ ! -d "$dotfiles_folder" ]]; then
  git clone https://github.com/tigion/dotfiles.git "$dotfiles_folder"
fi
"${dotfiles_folder}/install.sh --no-software"

# set zsh as default shell
printf "\nSet: zsh as default shell\n"
chsh -s "$(which zsh)"