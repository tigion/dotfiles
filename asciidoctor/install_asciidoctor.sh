#!/bin/bash
#
# Script für die lokale Installation von Asciidoctor unter Ubuntu und macOS

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# Exit immediately if a command returns a non-zero status
set -e

# helper

# check OS and platform
is_linux() { [[ $(uname -s) == "Linux" ]]; }
is_macos() { [[ $(uname -s) == "Darwin" ]]; }
is_arm64() { [[ "$(uname -m)" == "arm64" ]]; }
is_x86_64() { [[ "$(uname -m)" == "x86_64" ]]; }

# check if a command exists
is_command() { command -v "$1" &>/dev/null; }

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

# ruby
install ruby

# java (for asciidoctor-diagram)
install openjdk
if is_macos; then
	# brew info openjdk | sed '/==> Caveats/,/==>/!d;//d'
	is_arm64 && src_path="/opt/homebrew" || src_path="/usr/local"
  if [[ -f "${src_path}/opt/openjdk/libexec/openjdk.jdk" ]]; then
	  sudo ln -sfn "${src_path}/opt/openjdk/libexec/openjdk.jdk" "/Library/Java/JavaVirtualMachines/openjdk.jdk"
  fi
	#echo "export PATH=\"${src_path}/opt/openjdk/bin:$PATH\"" >> ~/.zshrc
fi

# asciidoctor
gem install asciidoctor
gem install asciidoctor-pdf
gem install rouge
gem install text-hyphen

# diagram (plantuml) support
install graphviz
gem install asciidoctor-diagram