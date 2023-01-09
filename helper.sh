#!/bin/bash

# set colors
COLOR_GRAY="\033[0;38;5;243m"
COLOR_BLUE="\033[0;34m"
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_NONE="\033[0m"

# set output
#printf "\r  "
#printf "\r\033[2K  ..."
title () {
  printf "\n${COLOR_GRAY}[${COLOR_BLUE} == ${COLOR_GRAY}]${COLOR_NONE}${COLOR_BLUE} ${1}${COLOR_NONE}\n"
}
subtitle () {
  printf "\n${COLOR_GRAY}[${COLOR_BLUE} -- ${COLOR_GRAY}]${COLOR_NONE}${COLOR_BLUE} ${1}${COLOR_NONE}\n"
}
info () {
  printf "${COLOR_GRAY}[${COLOR_BLUE} .. ${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
}
question () {
  printf "\n${COLOR_GRAY}[${COLOR_BLUE} ?? ${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
}
success () {
  printf "${COLOR_GRAY}[${COLOR_GREEN} OK ${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
}
warning () {
  printf "${COLOR_GRAY}[${COLOR_YELLOW}WARN${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
}
skip () {
  printf "${COLOR_GRAY}[${COLOR_YELLOW}SKIP${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
}
fail () {
  printf "${COLOR_GRAY}[${COLOR_RED}FAIL${COLOR_GRAY}]${COLOR_NONE} ${1}\n"
  exit 1
}

testMessages () {
  title "This is a title"
  subtitle "Subtitle"
  info "A little information"
  question "Are you ready?"
  success "Installed Neovim"
  warning "Folder is empty"
  skip "Configuration exists"
  fail "File not find"
}

optionState () {
  yes="${COLOR_GREEN}Yes${COLOR_NONE}"
  no="${COLOR_RED}No${COLOR_NONE}"
  if [[ "$1" == "true" ]]; then
    echo "$yes"
  else
    echo "$no"
  fi
}

showOptions () {
  subtitle "Options:"
  info "Install software: $(optionState $INSTALL_SOFTWARE)"
  info "Install configurations: $(optionState $INSTALL_CONFIG)"
  if [[ "$INSTALL_CONFIG" == "true" ]]; then
    info "- Overwrite existing ones: $(optionState $OVERWRITE_EXISTING_CONFIG)"
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      info "- Backup existing ones: $(optionState $BACKUP_EXISTING_CONFIG)"
      info "- Backup timestamp: $BACKUP_TIMESTAMP"
      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then
        info "- Backup symbolic links: $(optionState $BACKUP_EXISTING_CONFIG_LINK)"
      fi
    else
      info "- Skip existing config: $(optionState $SKIP_EXISTING_CONFIG)"
    fi
  fi
}

readyToStart () {
  question "Ready to start installation (y/n)?"
  read -n 1 answer
  printf "\r"
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    info "Bye"
    exit 0
  fi
  info "$answer"
}

installXcodeCommandLineTools () {
  subtitle "Xcode Command Line Tools"
  result=`xcode-select -p 1>/dev/null;echo $?`
  if [[ "$result" == 0 ]]; then
    success "Command Line Tools for Xcode are already installed"
  else
    xcode-select --install
    success "Installed Command Line Tools for Xcode"
  fi
}

installHomebrew () {
  subtitle "Homebrew"
  if command -v brew &> /dev/null; then
    success "Homebrew is already installed"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Installed Homebrew"
  fi
  brew bundle --file "$DOTFILES_ROOT/homebrew/Brewfile"
  success "Installed Homebrew bundle"
}

# ...
configType () {
  if [[ -h "$1" ]]; then
    if [[ -e  "$1" ]]; then
      echo "link"
    else
      echo "!link"
    fi
  elif [[ -f "$1" ]]; then
    echo "file"
  elif [[ -d "$1" ]]; then
    echo "directory"
  else
    echo "-"
  fi
}

link () {
  declare src="$1" dst="$2"
  declare srcType=$(configType "$src")
  declare dstType=$(configType "$dst")

  # handle non-existent source or empty target
  if [[ ! -e "$src" ]]; then
    skip "Source '$src' does not exist"
    return 0
  elif [[ -z "$dst" ]]; then
    skip "Target '$dst' for source '$src' is empty"
    return 0
  fi

  # handle existing configuration
  # -e ... file exists (can be a file, directory or symbolic link)
  # -h ... symbolic link exists, but can be a non-existent file,
  #        if a link exists to a target that no longer exists
  if [[ -e "$dst" || -h "$dst" ]]; then
    # overwrite
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      # set backup state, with special handling of symbolic links
      local doBackup="$BACKUP_EXISTING_CONFIG"
      if [[ -h "$dst" && "$BACKUP_EXISTING_CONFIG_LINK" == "false" ]]; then
        doBackup=false
      fi

      if [[ "$doBackup" == "true" ]]; then
        # remove with backup
        dstBackup="${dst}.backup-${BACKUP_TIMESTAMP}"
        mv "$dst" "$dstBackup"
        success "Moved existing $dstType '$dst' to '$dstBackup'"
      else
        # remove without backup
        rm -rf "$dst"
        success "Removed existing $dstType '$dst'"
      fi
    else
      if [[ "$SKIP_EXISTING_CONFIG" == "true" ]]; then
        # skip
        skip "$dstType '$dst' already exists"
      else
        # fail: the installation script stops 
        fail "$dstType '$dst' already exists"
      fi
    fi
  fi

  # create link
  local folder=$(dirname "$dst")
  if ! [[ -d "$folder" ]]; then
    mkdir -p "$folder"
    success "Created directory '$folder'"
  fi
  ln -s "$src" "$dst"
  success "Linked $srcType '$src' to '$dst'"
}

# bin
useBin () {
  subtitle "Bin"
  link "$DOTFILES_ROOT/bin" "$HOME/bin"
}

# git
useGit () {
  if command -v git &> /dev/null; then
    subtitle "Git"
    link "$DOTFILES_ROOT/git/.gitignore" "$HOME/.gitignore"
  fi
}

# ssh
useSsh () {
  if command -v ssh &> /dev/null; then
    subtitle "SSH"
    link "$DOTFILES_ROOT/ssh/custom" "$HOME/.config/ssh"
    link "$DOTFILES_ROOT/ssh/config" "$HOME/.ssh/config"
  fi
}

# zsh
useZsh () {
  #if command -v zsh &> /dev/null; then
  if [[ "${SHELL##*/}" == "zsh" ]]; then
    subtitle "Zsh"
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
}

# bash
useBash () {
  #if command -v bash &> /dev/null; then
  if [[ "${SHELL##*/}" == "bash" ]]; then
    subtitle "Bash"
    skip "TODO: Not yet supported!"
  fi
}

# fd
useFd () {
  if command -v fd &> /dev/null; then
    subtitle "fd"
    link "$DOTFILES_ROOT/fd" "$HOME/.config/fd"
  fi
}

# vim
useVim () {
  if command -v vim &> /dev/null; then
    subtitle "Vim"
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
}

# nvim
useNeovim () {
  if command -v zsh &> /dev/null; then
    subtitle "Neovim"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    #nvim --headless +PackerInstall +q
  fi
}

# kitty
useKitty () {
  if command -v kitty &> /dev/null; then
    subtitle "Kitty"
    link "$DOTFILES_ROOT/kitty" "$HOME/.config/kitty"
  fi
}
