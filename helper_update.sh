#!/usr/bin/env bash

# list options
show_options() {
  subtitle "Options:"
  info "Show update infos: $(get_yes_no true)"
  info "Install updates: $(get_yes_no "$INSTALL_UPDATES")"
}

# update Homebrew and installed software
update_homebrew() {
  if command -v brew &>/dev/null; then
    title "Homebrew"
    # info
    brew_version=$(brew --version)
    info "$brew_version"
    subtitle "brew outdated"
    brew outdated
    subtitle "brew outdated --cask --greedy"
    info "The following apps have auto-updates enabled and are not updated."
    info "Force update with 'brew upgrade <app name>'."
    brew outdated --cask --greedy
    # update
    if [[ "$INSTALL_UPDATES" == "true" ]]; then
      subtitle "brew upgrade"
      brew upgrade
      subtitle "brew update"
      brew update
    fi
    # clean up
    if [[ "$CLEAN_UP" == "true" && "$INSTALL_UPDATES" == "true" ]]; then
      subtitle "brew cleanup"
      brew autoremove
      brew cleanup -s --prune=14
      #rm -rf $(brew --cache)
    fi
    subtitle "brew doctor"
    # `brew doctor` exits with a non-zero status if any potential problems are found.
    # So we need to deactivate exit on error before and activate it again afterwards.
    set +e
    brew doctor
    set -e
  fi
}

# update Ruby package manager RubyGems and Gems
update_ruby() {
  if command -v gem &>/dev/null; then
    title "Ruby"
    ruby_version=$(ruby -v)
    info "$ruby_version"
    # check
    current_version=$(gem --version)
    info "gem $current_version"
    latest_version=$(curl -sf --max-time 5 "https://api.github.com/repositories/614070/releases/latest" | grep -o '"tag_name": *"[^"]*"' | cut -d'"' -f4 | tr -d 'v')
    min_version=$(printf '%s\n' "$current_version" "$latest_version" | sort -V | head -n1)
    if [[ $min_version == "$current_version" && $min_version != "$latest_version" ]]; then
      info "A new RubyGems version ${latest_version} is available."
    fi
    subtitle "gem outdated"
    gem outdated
    # update
    if [[ "$INSTALL_UPDATES" == "true" ]]; then
      subtitle "gem update --system"
      gem update --system
      subtitle "gem update"
      gem update
    fi
    # clean up
    if [[ "$CLEAN_UP" == "true" && "$INSTALL_UPDATES" == "true" ]]; then
      subtitle "gem cleanup"
      gem cleanup
    fi
  fi
}

# update Node global packages
update_node() {
  if command -v npm &>/dev/null; then
    title "Node.js"
    # info
    node_version=$(node -v)
    npm_version=$(npm -v)
    info "Node.js $node_version"
    info "npm $npm_version"
    subtitle "npm -g outdated"
    npm -g outdated
    # update
    if [[ "$INSTALL_UPDATES" == "true" ]]; then
      subtitle "npm -g update"
      npm -g update
    fi
  fi
}

# update Python package manager pip
update_python() {
  if command -v pip3 &>/dev/null; then
    title "Python pip"
    # info
    subtitle "pip3 --version"
    pip3 --version
    subtitle "pip3 list --outdated"
    pip3 list --outdated
    # update
    if [[ "$INSTALL_UPDATES" == "true" ]]; then
      echo "Manually upgrade each with:"
      echo "pip3 install --upgrade <package name>"
    fi
  fi
}
