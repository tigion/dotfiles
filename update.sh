#!/bin/bash

# TODO:
# - macOS: trigger system and app update
# - Node: npm updates (node -v, npm -v)

# set options
install_updates=false
if [[ "$1" == "--install" || "$1" == "-i" ]]; then
  install_updates=true
fi
clean_up=true

# update Homebrew and installed software
update_homebrew() {
  if command -v brew &>/dev/null; then
    printf "\nHomebrew:"
    # check
    brew -v
    brew outdated
    # update
    if [[ "$install_updates" == "true" ]]; then
      brew upgrade
      brew update
    fi
    # clean up
    if [[ "$clean_up" == "true" ]]; then
      brew autoremove
      brew cleanup -s --prune=14
      #rm -rf $(brew --cache)
      brew doctor
    fi
  fi
}

# update Ruby package manager RubyGems and Gems
update_ruby() {
  if command -v gem &>/dev/null; then
    printf "\nRubyGems, Gems:"
    # check
    current_version=$(gem --version)
    latest_version=$(curl -s https://api.github.com/repos/rubygems/rubygems/releases | grep -m 1 "html_url" | grep -o "releases/.*/.*" | tr -d "v\"," | cut -d"/" -f3)
    if [[ ${current_version//./} -lt ${latest_version//./} ]]; then
      echo "A new RubyGems version is available ($current_version < $latest_version)"
    else
      echo "RubyGems $current_version"
    fi
    gem outdated
    # update
    if [[ "$install_updates" == "true" ]]; then
      gem update --system
      gem update
    fi
    # clean up
    if [[ "$clean_up" == "true" ]]; then
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
    if [[ "$install_updates" == "true" ]]; then
      echo "Manually upgrade each with:"
      echo "pip3 install --upgrade <package name>"
    fi
  fi
}

update_homebrew
update_ruby
#update_python
