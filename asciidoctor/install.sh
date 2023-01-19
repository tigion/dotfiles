#!/bin/bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

# requirements
brew install ruby

# is java needed?
#brew install openjdk
#sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# asciidoctor
gem install asciidoctor
gem install asciidoctor-pdf
gem install rouge
gem install text-hyphen

# diagram support
brew install graphviz
gem install asciidoctor-diagram
