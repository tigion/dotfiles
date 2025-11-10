#!/usr/bin/env bash

# This script installs Asciidoctor and its dependencies on macOS and Linux systems.

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# Exit immediately if a command returns a non-zero status
set -e

# --- Helper functions ---

is_linux() { [[ $(uname -s) == "Linux" ]]; }
is_macos() { [[ $(uname -s) == "Darwin" ]]; }

is_command() { command -v "$1" &>/dev/null; }

# --- Install functions ---

install() {
  echo "> Installing '$1' ..."
  if is_macos; then
    if is_command brew; then
      brew install "$1"
    else
      echo "Homebrew is not installed. Please install Homebrew first: https://brew.sh"
      exit 1
    fi
  elif is_linux; then
    if is_command brew; then
      brew install "$1"
    elif is_command apt; then
      sudo apt install "$1"
    else
      echo "No supported package manager found (Homebrew or apt). Please install '$1' manually."
    fi
  fi
}

install_java() {
  # java (for asciidoctor-diagram)
  ! is_command java && install openjdk
  if is_macos; then
    # brew info openjdk | sed '/==> Caveats/,/==>/!d;//d'
    src_path=$(brew --prefix openjdk)
    if [[ -f "${src_path}/libexec/openjdk.jdk" ]]; then
      sudo ln -sfn "${src_path}/libexec/openjdk.jdk" "/Library/Java/JavaVirtualMachines/openjdk.jdk"
    fi
    echo "Add export PATH=\"${src_path}/bin:$PATH\" to ~/.zshrc"
  fi
}

# --- Install Asciidoctor with dependencies and extensions ---

# Ruby
! is_command ruby && install ruby

# Asciidoctor and extension
gem install asciidoctor
gem install asciidoctor-pdf
gem install rouge
gem install text-hyphen

# Asciidoctor diagram (plantuml) support
install_java
! is_command dot && install graphviz
gem install asciidoctor-diagram
gem install asciidoctor-diagram-plantuml
# gem install asciidoctor-diagram-ditaamini
