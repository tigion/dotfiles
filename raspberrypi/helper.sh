# lazygit
install_lazygit() {
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin

  return 0
}

# neovim needed tools
install_neovim_tools() {
  # ripgrep
  sudo apt install ripgrep

  # fd
  # - neovim hc: warning: fd not found
  # - apt: Unable to locate package fd

  # nodejs
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install nodejs

  # tree-sitter
  # - neovim hc: warning: tree-sitter-cli not found
  # - apt: Unable to locate package tree-sitter-cl
  # NOT NEEDED

  return 0
}

# neovim
install_neovim() {
  # neovim
  # - apt to old, build self
  # - https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
  # - https://github.com/neovim/neovim/wiki/Building-Neovim

  # Build prerequisites
  sudo apt-get install ninja-build gettext cmake unzip curl

  # clone neovim repository
  git clone https://github.com/neovim/neovim

  # build
  # - with ninja 9 minutes, without 13 minutes
  # - Linking C executable bin/nvi needs a wihle
  cd neovim || exit
  git checkout stable # use latest release tag (#0.9.1)
  make CMAKE_BUILD_TYPE=Release

  # install
  #sudo make install
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb && cd ..

  cd ..

  return 0
}
