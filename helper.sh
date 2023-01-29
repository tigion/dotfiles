#!/bin/bash

# colors
COLOR_GRAY="\033[0;38;5;243m"
COLOR_BLUE="\033[0;34m"
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_NONE="\033[0m"

# outputs
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

# check if not dry-run
isActive () {
  [[ "$OPTION_DRYRUN" == "true" ]] && printf "%b!%b" "$COLOR_YELLOW" "$COLOR_NONE"
  [[ "$OPTION_DRYRUN" != "true" ]]
}

# get true/false as yes/no
getYesNo () {
  local yes="${COLOR_GREEN}Yes${COLOR_NONE}"
  local no="${COLOR_RED}No${COLOR_NONE}"
  if [[ "$1" == "true" ]]; then echo "$yes"; else echo "$no"; fi
}

# check if a command exists
isCommand () {
  command -v "$1" &> /dev/null
}

# check if a config exists
isConfig () {
  # -e ... existent file, directory or symbolic link (with existent target)
  # -h ... existent symbolic link (with existent or non-existent target)
  [[ -e "$1" || -h "$1" ]]
}

# list options
showOptions () {
  subtitle "Options:"
  info "Install software: $(getYesNo "$INSTALL_SOFTWARE")"
  info "Install configurations: $(getYesNo "$INSTALL_CONFIG")"
  if [[ "$INSTALL_CONFIG" == "true" ]]; then
    info "- Overwrite existing ones: $(getYesNo "$OVERWRITE_EXISTING_CONFIG")"
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      info "- Backup existing ones: $(getYesNo "$BACKUP_EXISTING_CONFIG")"
      info "- Backup timestamp: $BACKUP_TIMESTAMP"
      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then
        info "- Backup symbolic links: $(getYesNo "$BACKUP_EXISTING_CONFIG_LINK")"
      fi
    else
      info "- Skip existing config: $(getYesNo "$SKIP_EXISTING_CONFIG")"
    fi
  fi
  if [[ "$OPTION_DRYRUN" == "true" ]]; then
    warning "Dry run, commands marked with '!' are not executed: $(getYesNo "$OPTION_DRYRUN")"
  fi
}

# ready to start
askToStart () {
  question "Ready to start installation (y/n)?"
  read -r -n 1 answer
  printf "\r"
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    info "Bye"
    exit 0
  fi
  info "$answer"
}

# install Xcode command line tools
installXcodeCommandLineTools () {
  subtitle "Xcode Command Line Tools"
  result=$(xcode-select -p 1>/dev/null; echo $?)
  if [[ "$result" == 0 ]]; then
    success "Command Line Tools for Xcode are already installed"
  else
    isActive && xcode-select --install
    success "Installed Command Line Tools for Xcode"
  fi
}

# install software via aHomebrew
installHomebrew () {
  subtitle "Homebrew"
  if isCommand brew; then
    success "Homebrew is already installed"
  else
    isActive && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Installed Homebrew"
  fi
  isActive && brew bundle --file "$DOTFILES_ROOT/homebrew/Brewfile"
  success "Installed Homebrew bundle"
}

# identify config type
getConfigType () {
  if [[ -h "$1" && -e "$1" ]]; then
    echo "link"
  elif [[ -h "$1" && ! -e "$1" ]]; then
    echo "!link"
  elif [[ -f "$1" ]]; then
    echo "file"
  elif [[ -d "$1" ]]; then
    echo "directory"
  else
    echo "-"
  fi
}

# creates a symbolic link and handles existing configurations
link () {
  local src="$1" dst="$2"
  local srcType dstType
  srcType=$(getConfigType "$src")
  dstType=$(getConfigType "$dst")
  srcName="${src/${HOME}/~}"
  dstName="${dst/${HOME}/~}"

  # handle non-existent source or empty target
  if ! isConfig "$src"; then
    skip "Source '$src' does not exist"
    return 0
  elif [[ -z "$dst" ]]; then
    skip "Target '$dst' for source '$src' is empty"
    return 0
  fi

  # handle existing configuration
  if isConfig "$dst"; then
    # source is allready linked
    if [[ -h "$dst" && $(readlink "$dst") == "$src" ]]; then
      success "Link '$dstName' is already the correct link"
      return
    fi

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
        isActive && mv "$dst" "$dstBackup"
        success "Moved existing $dstType '$dstName' to '${dstBackup##*/}'"
      else
        # remove without backup
        isActive && rm -rf "$dst"
        success "Removed existing $dstType '$dstName'"
      fi
    else
      if [[ "$SKIP_EXISTING_CONFIG" == "true" ]]; then
        skip "$dstType '$dstName' already exists"
      else
        fail "$dstType '$dstName' already exists"
      fi
    fi
  fi

  # create link
  parentDir=$(dirname "$dst")
  if [[ ! -d "$parentDir" ]]; then
    isActive && mkdir -p "$parentDir"
    success "Created directory '${parentDir/${HOME}/~}'"
  fi
  isActive && ln -s "$src" "$dst"
  success "Linked $srcType '$srcName' to '$dstName'"
}

# bin
useBin () {
  subtitle "Bin"
  link "$DOTFILES_ROOT/bin" "$HOME/bin"
}

# git
useGit () {
  if isCommand git; then
    subtitle "Git"
    link "$DOTFILES_ROOT/git/.gitignore" "$HOME/.gitignore"
  fi
}

# ssh
useSsh () {
  if isCommand ssh; then
    subtitle "SSH"
    link "$DOTFILES_ROOT/ssh/custom" "$HOME/.config/ssh"
    link "$DOTFILES_ROOT/ssh/config" "$HOME/.ssh/config"
  fi
}

# zsh
useZsh () {
  if isCommand zsh; then
    subtitle "Zsh"
    # Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      isActive && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      success "Installed Oh My Zsh"
    else
      success "Oh My Zsh is already installed"
    fi
    # Plugins
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
      isActive && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
      success "Installed zsh-autosuggestions"
    else
      success "zsh-autosuggestions is already installed"
    fi
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
      isActive && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
      success "Installed zsh-syntax-highlighting"
    else
      success "zsh-syntax-highlighting is already installed"
    fi
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/ohmyzsh-full-autoupdate" ]]; then
      isActive && git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
      success "Installed ohmyzsh-full-autoupdate"
    else
      success "ohmyzsh-full-autoupdate is already installed"
    fi
    # Theme Powerlevel10k
    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
      isActive && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
      success "Installed Powerlevel10k"
    else
      success "Powerlevel10k is already installed"
    fi

    link "$DOTFILES_ROOT/zsh/custom" "$HOME/.config/zsh"
    link "$DOTFILES_ROOT/zsh/.zshrc" "$HOME/.zshrc"
    link "$DOTFILES_ROOT/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
  fi
}

# bash
useBash () {
  if isCommand bash; then
    subtitle "Bash"
    skip "TODO: Not yet supported!"
  fi
}

# fd
useFd () {
  if isCommand fd; then
    subtitle "fd"
    link "$DOTFILES_ROOT/fd" "$HOME/.config/fd"
  fi
}

# vim
useVim () {
  if isCommand vim; then
    subtitle "Vim"
    if [[ ! -f "$HOME/.vim/colors/monokai.vim" ]]; then
      isActive && mkdir -p "$HOME/.vim/colors"
      isActive && curl -o https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -f "$HOME/.vim/colors/monokai.vim"
      success "Installed Monokai"
    else
      success "Monokai is already installed"
    fi
    if [[ ! -d "$HOME/.vim/pack/vendor/start/VimCompletesMe" ]]; then
      isActive && mkdir -p ~/.vim/pack
      isActive && git clone git://github.com/ajh17/VimCompletesMe.git "$HOME/.vim/pack/vendor/start/VimCompletesMe"
      success "Installed VimCompletesMe"
    else
      success "VimCompletesMe is already installed"
    fi
    link "$DOTFILES_ROOT/vim/.vimrc" "$HOME/.vimrc"
  fi
}

# nvim
useNeovim () {
  if isCommand zsh; then
    subtitle "Neovim"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    #isActive && nvim --headless +PackerInstall +q
  fi
}

# kitty
useKitty () {
  if isCommand kitty; then
    subtitle "Kitty"
    link "$DOTFILES_ROOT/kitty" "$HOME/.config/kitty"
  fi
}

# lazygit
useLazygit () {
  if isCommand lazygit; then
    subtitle "Lazygit"
    link "$DOTFILES_ROOT/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  fi
}
