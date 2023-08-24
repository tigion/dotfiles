# Raspberry Pi 4B

This document explains how to set up a **Raspberry Pi 4B** with an **Ubuntu Server** operating system.
It also contains installation instructions for some tools I use.

- [Setting up the Raspberry Pi](#setting-up-the-raspberry-pi)
  - [Prepare SD card with Operating System](#prepare-sd-card-with-operating-system)
  - [\[optional\] Activate network over USB-C (Zeroconf)](#optional-activate-network-over-usb-c-zeroconf)
  - [Prepare Raspberry Pi for first boot](#prepare-raspberry-pi-for-first-boot)
- [Software](#software)
  - [Base](#base)
  - [Programming languages](#programming-languages)
  - [Lazygit](#lazygit)
  - [Neovim](#neovim)
- [Dotfiles](#dotfiles)

## Setting up the Raspberry Pi

Required are:
- a Raspberry Pi 4B
- an SD card
- an internet connection
- a computer with a SD card slot

Sources:
- [Raspberry Pi iPad Pro Setup Simplified](https://techcraft.co/videos/2022/5/raspberry-pi-ipad-pro-setup-simplified/)
- [Setting up Raspberry Pi to work with your M1 iPad Pro](https://neoighodaro.com/posts/10-setting-up-raspberry-pi-to-work-with-your-ipad)

### Prepare SD card with Operating System

1. Load and install [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

2. With the **Raspberry Pi Imager** download and write the selected image on to an SD card:
  - Operating System:
    - `Ubuntu Server (64-bit)`/`Ubuntu Server LTS (64-bit)`
  - Storage: <choose an SD card>
  - Advanced options (Gear symbol in the lower right corner):
    - Set hostname, enable SSH, username, password, wifi, Language and no telemetry

### [optional] Activate network over USB-C (Zeroconf)

1. Put the SD card back into the computer

2. Edit the file *cmdline.txt*:
   - add `modules-load=dwc2,g_ether` with a space bevor `rootwait`

3. Edit the file *config.txt*:
   - add `dtoverlay=dwc2,dr_mode=peripheral` as the last line

4. On **Ubuntu Server (LTS)** edit the file *network-config*, to bring up the `usb0` interface by default:

   ```yaml
   version: 2
   wifis:
     renderer: networkd
     wlan0:
       dhcp4: true
       optional: true
       access-points:
         "<Wifi-Name>": <SSID-name>
           password: *****************
   ethernets:
     usb0:
       optional: true
       link-local: [ ipv4 ]
       #link-local: [ ipv6 ]
       #link-local: [ ipv4, ipv6 ]
   ```
> **Note:**
> If the Raspberry Pi is directly connected to a computer or iPad via USB-C to USDB-C cable, a new network interface `RNDIS/Ethernet Gadget` will appear in the network settings.

### Prepare Raspberry Pi for first boot

1. Insert SD card into the Raspberry Pi

2. Connect with a USB-C power adapter or directly via USB-C to USB-C cable to a computer/iPad

3. The first start takes a little moment

4. Login via SSH:
   - `ssh <hostname>` … if the Raspberry Pi is connected to a WLAN or via Ethernet cable
   - `ssh <hostname>.local` … if the Raspberry Pi is directly connected to a computer or iPad via USB-C and the network over USB-C is activated

5. Update: `sudo apt update && sudo apt upgrade`

6. Restart: `sudo reboot`


## Software

### Base

```sh
# git (already installed)
sudo apt install git

# zsh
sudo apt install zsh
# Set ZSH as default shell
chsh -s $(which zsh)

# tmux (already installed)
sudo apt install tmux

# mosh
sudo apt install mosh
```

### Programming languages

```sh
# Python
# - python (python3) schon vorhanden
sudo apt install python3, python3-pip, python3-venv

# PHP
sudo apt install php, composer, php-xml
```

### Lazygit

```sh
# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### Neovim

Install needed tools:
```sh
# ripgrep
# - neovim health check: warning: ripgrep not found
sudo apt install ripgrep

# fd
# - neovim health check: warning: fd not found
# - apt: Unable to locate package fd
# NOT NEEDED

# nodejs
# - neovim health check: warning: node not found
# - apt: Unable to locate package nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs

# tree-sitter
# - neovim health check: warning: tree-sitter-cli not found
# - apt: Unable to locate package tree-sitter-cl
# NOT NEEDED
```

Build Neovim from source (this takes about 15 minutes on the Raspberry Pi 4B):
```sh
# neovim
# - apt to old, build self
# - https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
# - https://github.com/neovim/neovim/wiki/Building-Neovim

# Build prerequisites
sudo apt-get install ninja-build gettext cmake unzip curl

# clone neovim repository
git clone https://github.com/neovim/neovim

# build
# - with ninja 9 minutes, without 13 minutes on Raspberry Pi 4B
# - Linking C executable bin/nvi needs a while
cd neovim && git checkout stable # use latest release tag (#0.9.1)
make CMAKE_BUILD_TYPE=Release

# install
#sudo make install
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
```

> Alternatively via **snap**:
> ```sh
> sudo apt install snapd
> sudo snap install --classic nvim
> ```
> I think `/snap/bin` must be in den $PATH or call `/snap/bin/nvim` directly.

## Dotfiles

```sh
# dotfiles
git clone https://github.com/tigion/dotfiles.git
cd dotfiles
./install.sh --no-software
```