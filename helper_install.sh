#!/usr/bin/env bash

# check if a config exists
is_config() {
  # -e ... existent file, directory or symbolic link (with existent target)
  # -h ... existent symbolic link (with existent or non-existent target)
  [[ -e "$1" || -L "$1" ]]
}

# list options
show_options() {
  subtitle "Options:"
  info "Install software: $(get_yes_no "$INSTALL_SOFTWARE")"
  info "Install configurations: $(get_yes_no "$INSTALL_CONFIG")"
  if [[ "$INSTALL_CONFIG" == "true" ]]; then
    info "- Overwrite existing ones: $(get_yes_no "$OVERWRITE_EXISTING_CONFIG")"
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      info "- Backup existing ones: $(get_yes_no "$BACKUP_EXISTING_CONFIG")"
      info "- Backup timestamp: $BACKUP_TIMESTAMP"
      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then
        info "- Backup symbolic links: $(get_yes_no "$BACKUP_EXISTING_CONFIG_LINK")"
      fi
    else
      info "- Skip existing config: $(get_yes_no "$SKIP_EXISTING_CONFIG")"
    fi
  fi
  if [[ "$OPTION_DRYRUN" == "true" ]]; then
    warning "Dry run, commands marked with '!' are not executed: $(get_yes_no "$OPTION_DRYRUN")"
  fi
}

# install Xcode command line tools
install_xcode_cli() {
  subtitle "Xcode Command Line Tools"
  result=$(
    xcode-select -p 1>/dev/null
    echo $?
  )
  if [[ "$result" == 0 ]]; then
    success "Command Line Tools for Xcode are already installed"
  else
    is_active && xcode-select --install
    success "Installed Command Line Tools for Xcode"
  fi
}

# install software via Homebrew
install_homebrew() {
  subtitle "Homebrew"
  if is_command brew; then
    success "Homebrew is already installed"
  else
    is_active && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Installed Homebrew"
  fi
  is_active && brew bundle --file "$DOTFILES_ROOT/homebrew/Brewfile"
  success "Installed Homebrew bundle"
}

# identify config type
get_config_type() {
  if [[ -L "$1" && -e "$1" ]]; then
    echo "link"
  elif [[ -L "$1" && ! -e "$1" ]]; then
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
link() {
  local src="$1" dst="$2"
  local src_type dst_type
  src_type=$(get_config_type "$src")
  dst_type=$(get_config_type "$dst")
  src_name="${src/${HOME}/~}"
  dst_name="${dst/${HOME}/~}"

  # handle non-existent source or empty target
  if ! is_config "$src"; then
    skip "Source '$src' does not exist"
    return 0
  elif [[ -z "$dst" ]]; then
    skip "Target '$dst' for source '$src' is empty"
    return 0
  fi

  # handle existing configuration
  if is_config "$dst"; then
    # source is already linked
    if [[ -L "$dst" && $(readlink "$dst") == "$src" ]]; then
      success "Link '$dst_name' is already the correct link"
      return
    fi

    # overwrite
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      # set backup state, with special handling of symbolic links
      local do_backup="$BACKUP_EXISTING_CONFIG"
      if [[ -L "$dst" && "$BACKUP_EXISTING_CONFIG_LINK" == "false" ]]; then
        do_backup=false
      fi

      if [[ "$do_backup" == "true" ]]; then
        # remove with backup
        dst_backup="${dst}.backup-${BACKUP_TIMESTAMP}"
        is_active && mv "$dst" "$dst_backup"
        success "Moved existing $dst_type '$dst_name' to '${dst_backup##*/}'"
      else
        # remove without backup
        is_active && rm -rf "$dst"
        success "Removed existing $dst_type '$dst_name'"
      fi
    else
      if [[ "$SKIP_EXISTING_CONFIG" == "true" ]]; then
        skip "$dst_type '$dst_name' already exists"
      else
        fail "$dst_type '$dst_name' already exists"
      fi
    fi
  fi

  # create link
  parent_dir=$(dirname "$dst")
  if [[ ! -d "$parent_dir" ]]; then
    is_active && mkdir -p "$parent_dir"
    success "Created directory '${parent_dir/${HOME}/~}'"
  fi
  is_active && ln -s "$src" "$dst"
  success "Linked $src_type '$src_name' to '$dst_name'"
}

# bin
use_bin() {
  subtitle "Bin"
  link "$DOTFILES_ROOT/bin" "$HOME/bin"
}

# git
use_git() {
  if is_command git; then
    subtitle "Git"
    link "$DOTFILES_ROOT/git" "$HOME/.config/git"
  fi
}

# ssh
use_ssh() {
  if is_command ssh; then
    subtitle "SSH"
    link "$DOTFILES_ROOT/ssh/custom" "$HOME/.config/ssh"
    link "$DOTFILES_ROOT/ssh/config" "$HOME/.ssh/config"
  fi
}

# zsh
use_zsh() {
  if is_command zsh; then
    subtitle "Zsh"
    # Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      is_active && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      success "Installed Oh My Zsh"
    else
      success "Oh My Zsh is already installed"
    fi
    # Plugins
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
      is_active && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
      success "Installed zsh-autosuggestions"
    else
      success "zsh-autosuggestions is already installed"
    fi
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
      is_active && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
      success "Installed zsh-syntax-highlighting"
    else
      success "zsh-syntax-highlighting is already installed"
    fi
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/ohmyzsh-full-autoupdate" ]]; then
      is_active && git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
      success "Installed ohmyzsh-full-autoupdate"
    else
      success "ohmyzsh-full-autoupdate is already installed"
    fi
    # Theme Powerlevel10k
    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
      is_active && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
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
use_bash() {
  if is_command bash; then
    subtitle "Bash"
    skip "TODO: Not yet supported!"
  fi
}

# fd
use_fd() {
  if is_command fd; then
    subtitle "fd"
    link "$DOTFILES_ROOT/fd" "$HOME/.config/fd"
  fi
}

# tmux terminfo
# https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
install_tmux_terminfo() {
  src="$DOTFILES_ROOT/macOS/tmux-256color/tmux-256color.src"
  dst="$HOME/.local/share/terminfo"
  if [[ ! -f $HOME/.local/share/terminfo/74/tmux-256color ]]; then
    is_active && /usr/bin/tic -x -o "$dst" "$src"
    success "Installed tmux-256color"
  else
    success "tmux-256color is already installed"
  fi
}

# tmux
use_tmux() {
  if is_command tmux; then
    subtitle "tmux"
    is_macos && install_tmux_terminfo
    link "$DOTFILES_ROOT/tmux" "$HOME/.config/tmux"
  fi
}

# vim
use_vim() {
  if is_command vim; then
    subtitle "Vim"
    if [[ ! -f "$HOME/.vim/colors/monokai.vim" ]]; then
      is_active && mkdir -p "$HOME/.vim/colors"
      is_active && curl https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -o "$HOME/.vim/colors/monokai.vim"
      success "Installed Monokai"
    else
      success "Monokai is already installed"
    fi
    if [[ ! -d "$HOME/.vim/pack/vendor/start/VimCompletesMe" ]]; then
      is_active && mkdir -p "$HOME/.vim/pack"
      is_active && git clone https://github.com/vim-scripts/VimCompletesMe.git "$HOME/.vim/pack/vendor/start/VimCompletesMe"
      success "Installed VimCompletesMe"
    else
      success "VimCompletesMe is already installed"
    fi
    link "$DOTFILES_ROOT/vim/.vimrc" "$HOME/.vimrc"
  fi
}

# nvim
use_neovim() {
  if is_command nvim; then
    subtitle "Neovim"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    #is_active && nvim --headless +PackerInstall +q
    # install spell files
    # '$HOME/.config/nvim/spell/'
    # wget 'https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl'
    # wget 'https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.sug'
    local installed=false
    if [[ ! -d "$HOME/.config/nvim/spell" ]]; then
      is_active && mkdir -p "$HOME/.config/nvim/spell"
    fi
    local file="de.utf-8.spl"
    if [[ ! -f "$HOME/.config/nvim/spell/${file}" ]]; then
      is_active && curl "https://ftp.nluug.nl/pub/vim/runtime/spell/${file}" -o "$HOME/.config/nvim/spell/${file}"
      installed=true
    fi
    file="de.utf-8.sug"
    if [[ ! -f "$HOME/.config/nvim/spell/${file}" ]]; then
      is_active && curl "https://ftp.nluug.nl/pub/vim/runtime/spell/${file}" -o "$HOME/.config/nvim/spell/${file}"
      installed=true
    fi
    if [[ $installed == true ]]; then
      success "Installed German spell files"
    else
      success "German spell files are already installed"
    fi
  fi
}

# kitty
use_kitty() {
  if is_command kitty; then
    subtitle "Kitty"
    link "$DOTFILES_ROOT/kitty" "$HOME/.config/kitty"
  fi
}

# lazygit
use_lazygit() {
  if is_command lazygit; then
    subtitle "Lazygit"
    link "$DOTFILES_ROOT/lazygit" "$HOME/.config/lazygit"
  fi
}

# use_httpie
use_httpie() {
  if is_command http; then
    subtitle "httpie"
    link "$DOTFILES_ROOT/httpie" "$HOME/.config/httpie"
  fi
}

# fzf
use_fzf() {
  if is_command fzf; then
    subtitle "fzf"
    link "$DOTFILES_ROOT/fzf" "$HOME/.config/fzf"
  fi
}

# ghostty
use_ghostty() {
  if is_command ghostty; then
    subtitle "Ghostty"
    link "$DOTFILES_ROOT/ghostty" "$HOME/.config/ghostty"
  fi
}

# btop
use_btop() {
  if is_command btop; then
    subtitle "btop"
    link "$DOTFILES_ROOT/btop" "$HOME/.config/btop"
  fi
}

# fastfetch
use_fastfetch() {
  if is_command fastfetch; then
    subtitle "fastfetch"
    link "$DOTFILES_ROOT/fastfetch" "$HOME/.config/fastfetch"
  fi
}
