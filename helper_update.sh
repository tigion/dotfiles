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
    # check
    brew -v
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
    # printf "\nRubyGems, Gems:"
    # check
    current_version=$(gem --version)
    latest_version=$(curl -s https://api.github.com/repos/rubygems/rubygems/releases | grep -m 1 "html_url" | grep -o "releases/.*/.*" | tr -d "v\"," | cut -d"/" -f3)
    if [[ ${current_version//./} -lt ${latest_version//./} ]]; then
      info "A new RubyGems version is available ($current_version < $latest_version)"
    else
      info "RubyGems $current_version"
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

# update Python package manager pip
update_python() {
  if command -v pip3 &>/dev/null; then
    printf "\nPython pip:"
    # check
    pip3 --version
    pip3 list --outdated
    # update
    if [[ "$INSTALL_UPDATES" == "true" ]]; then
      echo "Manually upgrade each with:"
      echo "pip3 install --upgrade <package name>"
    fi
  fi
}
