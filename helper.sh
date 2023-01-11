#!/bin/bash

# exits with true if option for dry-run is false
doIt () {
  [[ "$OPTION_DRYRUN" == "true" ]] && printf "%b!%b" "$COLOR_YELLOW" "$COLOR_NONE"
  [[ "$OPTION_DRYRUN" != "true" ]]
}

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
  printf "\n%b[%b == %b]%b %b%b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_BLUE" "$1" "$COLOR_NONE"
}
subtitle () {
  printf "\n%b[%b -- %b]%b %b%b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_BLUE" "$1" "$COLOR_NONE"
}
info () {
  printf "%b[%b .. %b]%b %b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
question () {
  printf "\n%b[%b ?? %b]%b %b\n" "$COLOR_GRAY" "$COLOR_BLUE" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
success () {
  printf "%b[%b OK %b]%b %b\n" "$COLOR_GRAY" "$COLOR_GREEN" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
warning () {
  printf "%b[%bWARN%b]%b %b\n" "$COLOR_GRAY" "$COLOR_YELLOW" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
skip () {
  printf "%b[%bSKIP%b]%b %b\n" "$COLOR_GRAY" "$COLOR_YELLOW" "$COLOR_GRAY" "$COLOR_NONE" "$1"
}
fail () {
  printf "%b[%bFAIL%b]%b %b\n" "$COLOR_GRAY" "$COLOR_RED" "$COLOR_GRAY" "$COLOR_NONE" "$1"
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
  local yes="${COLOR_GREEN}Yes${COLOR_NONE}"
  local no="${COLOR_RED}No${COLOR_NONE}"
  if [[ "$1" == "true" ]]; then
    echo "$yes"
  else
    echo "$no"
  fi
}

showOptions () {
  subtitle "Options:"
  info "Install software: $(optionState "$INSTALL_SOFTWARE")"
  info "Install configurations: $(optionState "$INSTALL_CONFIG")"
  if [[ "$INSTALL_CONFIG" == "true" ]]; then
    info "- Overwrite existing ones: $(optionState "$OVERWRITE_EXISTING_CONFIG")"
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      info "- Backup existing ones: $(optionState "$BACKUP_EXISTING_CONFIG")"
      info "- Backup timestamp: $BACKUP_TIMESTAMP"
      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then
        info "- Backup symbolic links: $(optionState "$BACKUP_EXISTING_CONFIG_LINK")"
      fi
    else
      info "- Skip existing config: $(optionState "$SKIP_EXISTING_CONFIG")"
    fi
  fi
  if [[ "$OPTION_DRYRUN" == "true" ]]; then
    warning "Dry run, commands marked with '!' are not executed: $(optionState "$OPTION_DRYRUN")"
  fi
}

existsCommand () {
  command -v "$1" &> /dev/null
  #command -v "$1" >/dev/null 2>&1
}

existsFile () {
  [[ -e "$1" ]]
  #[ -e "$1" ]
  #test -e "$1"
}

readyToStart () {
  question "Ready to start installation (y/n)?"
  read -r -n 1 answer
  printf "\r"
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    info "Bye"
    exit 0
  fi
  info "$answer"
}

installXcodeCommandLineTools () {
  subtitle "Xcode Command Line Tools"
  result=$(xcode-select -p 1>/dev/null; echo $?)
  if [[ "$result" == 0 ]]; then
    success "Command Line Tools for Xcode are already installed"
  else
    doIt && xcode-select --install
    success "Installed Command Line Tools for Xcode"
  fi
}

installHomebrew () {
  subtitle "Homebrew"
  if existsCommand brew; then
    success "Homebrew is already installed"
  else
    doIt && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Installed Homebrew"
  fi
  doIt && brew bundle --file "$DOTFILES_ROOT/homebrew/Brewfile"
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
  local src="$1" dst="$2"
  local srcType dstType
  srcType=$(configType "$src")
  dstType=$(configType "$dst")

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
        doIt && mv "$dst" "$dstBackup"
        success "Moved existing $dstType '$dst' to '$dstBackup'"
      else
        # remove without backup
        doIt && rm -rf "$dst"
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
  local folder
  folder=$(dirname "$dst")
  if ! [[ -d "$folder" ]]; then
    doIt && mkdir -p "$folder"
    success "Created directory '$folder'"
  fi
  doIt && ln -s "$src" "$dst"
  success "Linked $srcType '$src' to '$dst'"
}

# bin
useBin () {
  subtitle "Bin"
  link "$DOTFILES_ROOT/bin" "$HOME/bin"
}

# git
useGit () {
  if existsCommand git; then
    subtitle "Git"
    link "$DOTFILES_ROOT/git/.gitignore" "$HOME/.gitignore"
  fi
}

# ssh
useSsh () {
  if existsCommand ssh; then
    subtitle "SSH"
    link "$DOTFILES_ROOT/ssh/custom" "$HOME/.config/ssh"
    link "$DOTFILES_ROOT/ssh/config" "$HOME/.ssh/config"
  fi
}

# zsh
useZsh () {
  #if existsCommand zsh; then
  if [[ "${SHELL##*/}" == "zsh" ]]; then
    subtitle "Zsh"
    # Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      doIt && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      success "Installed Oh My Zsh"
    else
      success "Oh My Zsh is already installed"
    fi
    # Powerlevel10k
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      doIt && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
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
  #if existsCommand bash; then
  if [[ "${SHELL##*/}" == "bash" ]]; then
    subtitle "Bash"
    skip "TODO: Not yet supported!"
  fi
}

# fd
useFd () {
  if existsCommand fd; then
    subtitle "fd"
    link "$DOTFILES_ROOT/fd" "$HOME/.config/fd"
  fi
}

# vim
useVim () {
  if existsCommand vim; then
    subtitle "Vim"
    if [[ ! -f "$HOME/.vim/colors/monokai.vim" ]]; then 
      doIt && mkdir -p "$HOME/.vim/colors"
      doIt && curl -o https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -f "$HOME/.vim/colors/monokai.vim"
      success "Installed Monokai"
    else
      success "Monokai is already installed"
    fi
    if [[ ! -d "$HOME/.vim/pack/vendor/start/VimCompletesMe" ]]; then 
      doIt && mkdir -p ~/.vim/pack
      doIt && git clone git://github.com/ajh17/VimCompletesMe.git "$HOME/.vim/pack/vendor/start/VimCompletesMe"
      success "Installed VimCompletesMe"
    else
      success "VimCompletesMe is already installed"
    fi
    link "$DOTFILES_ROOT/vim/.vimrc" "$HOME/.vimrc"
  fi
}

# nvim
useNeovim () {
  if existsCommand zsh; then
    subtitle "Neovim"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    #doIt && nvim --headless +PackerInstall +q
  fi
}

# kitty
useKitty () {
  if existsCommand kitty; then
    subtitle "Kitty"
    link "$DOTFILES_ROOT/kitty" "$HOME/.config/kitty"
  fi
}

# lazygit
useLazygit () {
  if existsCommand lazygit; then
    subtitle "Lazygit"
    link "$DOTFILES_ROOT/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  fi
}
