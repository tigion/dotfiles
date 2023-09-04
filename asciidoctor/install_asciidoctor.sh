#!/bin/bash
#
# Script für die lokale Installation von Asciidoctor unter Ubuntu und macOS

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# Exit immediately if a command returns a non-zero status
set -e

# helper

# check OS
is_linux() {
  [[ $(uname -s) == "Linux" ]]
}
is_macos() {
  [[ $(uname -s) == "Darvin" ]]
}

# check if a command exists
is_command() {
  command -v "$1" &>/dev/null
}

# OS dependent installation
install() {
  echo "> Installing '$1' ..."
  if is_macos; then
    brew install "$1"
  elif is_linux; then
    sudo apt install "$1"
  fi
}

# install Asciidoctor

# requirements
install ruby
# is java for asciidoc-diagram needed?
install openjdk
# macOS:
# echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> ~/.zshrc

# asciidoctor
gem install asciidoctor
gem install asciidoctor-pdf
gem install rouge
gem install text-hyphen

# diagram (plantuml) support
install graphviz
gem install asciidoctor-diagram