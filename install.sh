#!/bin/bash

# TODO
# 

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# use absolute paths
DOTFILES_ROOT="$(pwd)"

# options
INSTALL_SOFTWARE=false
INSTALL_CONFIG=true
OVERWRITE_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG=true
BACKUP_EXISTING_CONFIG_LINK=false
SKIP_EXISTING_CONFIG=true

# parameters
BACKUP_TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"

# Exit immediately if a command returns a non-zero status
set -e

# load helper functions
source "${DOTFILES_ROOT}/helper.sh"

# start
showOptions
echo ''
user 'Ready to start installation (y/n)?'
read -n 1 answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
  info "Bye"
  exit
fi
info "$answer\n"

# 1. install software
if [[ "$INSTALL_SOFTWARE" == "true" ]]; then
  info "--- Install Software ---"

  # Xcode Command Line Tools
  xx=`xcode-select -p 1>/dev/null;echo $?`
  if [[ "$xx" == 0 ]]; then
    success "Command Line Tools for Xcode are already installed"
  else
    xcode-select --install
    success "Installed Command Line Tools for Xcode"
  fi

  # Homebrew
  if command -v brew &> /dev/null; then
    success "Homebrew is already installed"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Installed Homebrew"
  fi
  brew bundle --file "$DOTFILES_ROOT/homebrew/Brewfile"
  success "Installed Homebrew bundle"
  echo ''
fi

# 2. link configs and install dependies
if [[ "$INSTALL_CONFIG" == "true" ]]; then
  info "--- Install Configurations ---"

  # bin (own scripts)
  info "Bin:"
  link "$DOTFILES_ROOT/bin" "$HOME/bin"

  # git
  if command -v git &> /dev/null; then
    info "Git:"
    link "$DOTFILES_ROOT/git/.gitignore" "$HOME/.gitignore"
  fi
  
  # zsh
  #if command -v zsh &> /dev/null; then
  if [[ "${SHELL##*/}" == "zsh" ]]; then
    info "Zsh:"
    # Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      #sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      success "Installed Oh My Zsh"
    else
      success "Oh My Zsh is already installed"
    fi
    # Powerlevel10k
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      #git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
      success "Installed Powerlevel10k"
    else
      success "Powerlevel10k is already installed"
    fi

    link "$DOTFILES_ROOT/zsh/custom" "$HOME/.config/zsh"
    link "$DOTFILES_ROOT/zsh/.zshrc" "$HOME/.zshrc"
  fi

  # bash
  #if command -v bash &> /dev/null; then
  if [[ "${SHELL##*/}" == "bash" ]]; then
    info "Bash:"
    skip "TODO: Not yet supported!"
  fi
  
  # fd
  if command -v fd &> /dev/null; then
    info "fd:"
    link "$DOTFILES_ROOT/fd" "$HOME/.config/fd"
  fi
  
  # vim
  if command -v vim &> /dev/null; then
    info "Vim:"
    if [[ ! -f "$HOME/.vim/colors/monokai.vim" ]]; then 
      #mkdir -p "$HOME/.vim/colors"
      #curl -o https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -f "$HOME/.vim/colors/monokai.vim"
      success "Installed Monokai"
    else
      success "Monokai is already installed"
    fi
    if [[ ! -d "$HOME/.vim/pack/vendor/start/VimCompletesMe" ]]; then 
      #mkdir -p ~/.vim/pack
      #git clone git://github.com/ajh17/VimCompletesMe.git "$HOME/.vim/pack/vendor/start/VimCompletesMe"
      success "Installed VimCompletesMe"
    else
      success "VimCompletesMe is already installed"
    fi
    link "$DOTFILES_ROOT/vim/.vimrc" "$HOME/.vimrc"
  fi

  # nvim
  if command -v zsh &> /dev/null; then
    info "Neovim:"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    #nvim --headless +PackerInstall +q
  fi

  # kitty
  if command -v kitty &> /dev/null; then
    info "Kitty:"
    link "$DOTFILES_ROOT/kitty" "$HOME/.config/kitty"
  fi

  echo ''
fi

info "Finished"
