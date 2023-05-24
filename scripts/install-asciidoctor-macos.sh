#!/bin/bash

# TODO:
# - check if brew is installed
# - check is ruby is installed

# ruby
brew install ruby

# java
brew install openjdk
#echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> ~/.zshrc

# asciidoctor
gem install asciidoctor
gem install asciidoctor-pdf
gem install rouge

# plantuml
brew install graphviz
gem install asciidoctor-diagram

# optional
gem install text-hyphen
