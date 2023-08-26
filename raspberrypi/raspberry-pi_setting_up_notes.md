# Raspberry Pi 4B: The setup

This document explains how to set up a **Raspberry Pi 4B** with an **Ubuntu Server** operating system.
It also contains installation instructions for some tools I use and notes to use a **encrypted data partition**.

- [Raspberry Pi 4B: The setting up](#raspberry-pi-4b-the-setting-up)
  - [Install Ubuntu Server](#install-ubuntu-server)
    - [Prepare SD card with Operating System](#prepare-sd-card-with-operating-system)
    - [\[optional\] Activate network over USB-C (Zeroconf)](#optional-activate-network-over-usb-c-zeroconf)
    - [Prepare Raspberry Pi for first boot](#prepare-raspberry-pi-for-first-boot)
  - [Install Software](#install-software)
    - [Base](#base)
    - [Programming languages](#programming-languages)
    - [Lazygit](#lazygit)
    - [Neovim](#neovim)
  - [Install Dotfiles](#install-dotfiles)
  - [Create a protected (encrypted) data partition on the SD card](#create-a-protected-encrypted-data-partition-on-the-sd-card)
    - [Shrink partition and create a new one with the free size](#shrink-partition-and-create-a-new-one-with-the-free-size)
    - [Encrypt the new partition](#encrypt-the-new-partition)
    - [Daily handling](#daily-handling)
    - [\[optional\] Move .git-credentials to the protected data folder](#optional-move-git-credentials-to-the-protected-data-folder)
  - [Optimizations (disk i/o, power consuming)](#optimizations-disk-io-power-consuming)
    - [Disable unneeded services](#disable-unneeded-services)

## Install Ubuntu Server

Requirements:

- a Raspberry Pi 4B
- an SD card
- an internet connection
- a computer with a SD card slot or SD card reader

Sources:

- [Raspberry Pi iPad Pro Setup Simplified](https://techcraft.co/videos/2022/5/raspberry-pi-ipad-pro-setup-simplified/)
- [Setting up Raspberry Pi to work with your M1 iPad Pro](https://neoighodaro.com/posts/10-setting-up-raspberry-pi-to-work-with-your-ipad)

### Prepare SD card with Operating System

1. Load and install [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

2. With the **Raspberry Pi Imager** download and write the selected image on to an SD card:

   - Operating System:
     - `Ubuntu Server (64-bit)`/`Ubuntu Server LTS (64-bit)`
   - Storage:
     - `<choose the SD card>`
   - Advanced options (Gear symbol in the lower right corner):
     - Set hostname, enable SSH, username, password, wifi, Language and no telemetry

### [optional] Activate network over USB-C (Zeroconf)

1. Put the SD card back into the computer

2. Edit the file _cmdline.txt_:

   - add `modules-load=dwc2,g_ether` with a space bevor `rootwait`

3. Edit the file _config.txt_:

   - add `dtoverlay=dwc2,dr_mode=peripheral` as the last line

4. On **Ubuntu Server (LTS)** edit the file _network-config_, to bring up the `usb0` interface by default:

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
   > If the Raspberry Pi is directly connected to a computer or iPad via USB-C to USB-C cable, a new network interface `RNDIS/Ethernet Gadget` will appear in the network settings.

### Prepare Raspberry Pi for first boot

1. Insert SD card into the Raspberry Pi

2. Connect with a USB-C power adapter or directly via USB-C to USB-C cable to a computer/iPad

3. The first start takes a little moment

4. Login via SSH:

   - `ssh <hostname>` … if the Raspberry Pi is connected to a WLAN or via Ethernet cable
   - `ssh <hostname>.local` … if the Raspberry Pi is directly connected to a computer or iPad via USB-C and the network over USB-C is activated

5. Update: `sudo apt update && sudo apt upgrade`

6. Restart: `sudo reboot`

## Install Software

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
>
> ```sh
> sudo apt install snapd
> sudo snap install --classic nvim
> ```
>
> I think `/snap/bin` must be in den $PATH or call `/snap/bin/nvim` directly.

## Install Dotfiles

```sh
# dotfiles
git clone https://github.com/tigion/dotfiles.git
cd dotfiles
./install.sh --no-software
```

## Create a protected (encrypted) data partition on the SD card

Requirments:

- A computer with Linux and a SD card slot or SD card reader
- Tools: `resize2fs`, `fdisk` and `cryptsetup`

Sources:

- [How to Protect Your Raspberry Pi Data From Loss or Theft](https://www.makeuseof.com/how-to-protect-your-raspberry-pi-data-from-loss-or-theft/)
- [How to Encrypt and Decrypt a Partition in Raspberry Pi](https://linuxhint.com/encrypt-decrypt-partition-raspberry-pi/)
- [How To Enable LUKS Disk Encryption on Raspberry Pi 4 with Ubuntu Desktop 20.10](https://devicetests.com/enable-luks-disk-encryption-raspberry-pi-4-ubuntu-desktop)

### Shrink partition and create a new one with the free size

1. Plug the SD card in a Linux Computer

2. List and identify the SD card devices:

   ```sh
   $ lsblk
   sdb                         8:16   1 119,1G  0 disk
   ├─sdb1                      8:17   1   256M  0 part
   └─sdb2                      8:18   1 118,9G  0 part
   ```

   - `sdb1` ... is the **boot** partition
   - `sdb2` ... is the **root** partition we want to shrink

3. Shrink `sdb2` to the new smaller size:

   ```sh
   $ sudo resize2fs /dev/sdb2 50G
   Resizing the filesystem on /dev/sdb2 to 13107200 (4k) blocks.
   The filesystem on /dev/sdb2 is now 13107200 (4k) blocks long.
   ```

   - if needed check before: `sudo e2fsck -f /dev/sdb2`
   - `50G` is the new size of the `118,9G` partition, so now `68,8 GB` are free for the later encrypted partition
   - calc new block size (later for fdisk): `13107200 * 4 = +52428800K`

4. Update the partition information for `sdb2` (shrinked size) and a new `sdb3` (freed size):

   ```sh
   $ fdisk /dev/sdb
   ```

   1. Show current partition entries:

      ```sh
      # print the partition table
      Command (m for help): p
      Device     Boot  Start       End   Sectors   Size Id Type
      /dev/sdb1  *      2048    526335    524288   256M  c W95 FAT32 (LBA)
      /dev/sdb2       526336 249737182 249210847 118,9G 83 Linux
      ```

   2. Remove partition entry for `/dev/sdb2`:

      ```sh
      Command (m for help): d
      Partition number (1,2, default 2): 2
      Partition 2 has been deleted.
      ```

   3. Add partition entry for `/dev/sdb2` again with the new, reduced size:

      ```sh
      Command (m for help): n
      Partition type
         p   primary (1 primary, 0 extended, 3 free)
         e   extended (container for logical partitions)
      Select (default p): p
      Partition number (2-4, default 2): 2
      First sector (526336-249737215, default 526336):
      Last sector, +/-sectors or +/-size{K,M,G,T,P} (526336-249737215, default 249737215): +52428800K

      Created a new partition 2 of type 'Linux' and of size 50 GiB.
      Partition #2 contains a ext4 signature.
      Do you want to remove the signature? [Y]es/[N]o: N
      ```

      - Partition type: `p`
      - Partition number: `2`
      - First sector: `default`
      - Last sector: `+52428800K` (the pre-calculated size)

   4. Add partition entry for `/dev/sdb3` with the free size:

      ```sh
      # add a new partition
      # - add new /dev/sdb3
      Command (m for help): n
      Partition type
         p   primary (2 primary, 0 extended, 2 free)
         e   extended (container for logical partitions)
      Select (default p): p
      Partition number (3,4, default 3): 3
      First sector (105383936-249737215, default 105383936):
      Last sector, +/-sectors or +/-size{K,M,G,T,P} (105383936-249737215, default 249737215):

      Created a new partition 3 of type 'Linux' and of size 68,9 GiB.
      ```

      - Partition type: `p`
      - Partition number: `3`
      - First sector: `default`
      - Last sector: `default`

   5. Show modified partition entries:

      ```sh
      # print the partition table
      Command (m for help): p
      Device     Boot     Start       End   Sectors  Size Id Type
      /dev/sdb1  *         2048    526335    524288  256M  c W95 FAT32 (LBA)
      /dev/sdb2          526336 105383935 104857600   50G 83 Linux
      /dev/sdb3       105383936 249737215 144353280 68,9G 83 Linux
      ```

   6. Write the new partition informations to the SD card:
      ```sh
      # write table to disk and exit
      Command (m for help): w
      The partition table has been altered.
      Calling ioctl() to re-read partition table.
      Syncing disks.
      ```

### Encrypt the new partition

1. Start the Raspberry Pi from the SD card.

2. Show the SD card devices, there is a new third `mmcblk0p3`:

   ```sh
   $ lsblk
   ...
   mmcblk0       179:0    0 119.1G  0 disk
   ├─mmcblk0p1   179:1    0   256M  0 part  /boot/firmware
   ├─mmcblk0p2   179:2    0    50G  0 part  /
   └─mmcblk0p3   179:3    0  68.8G  0 part
   ```

3. Encrypt the new `/dev/mmcblk0p3` Partition:

   ```sh
   $ sudo cryptsetup -y -v luksFormat /dev/mmcblk0p3
   WARNING!
   ========
   This will overwrite data on /dev/mmcblk0p3 irrevocably.

   Are you sure? (Type 'yes' in capital letters): YES
   Enter passphrase for /dev/mmcblk0p3:
   Verify passphrase:
   Key slot 0 created.
   Command successful.
   ```

4. Unlock (open) the encrypted partition with the passphrase:

   ```sh
   #$ sudo cryptsetup luksOpen /dev/mmcblk0p3 data
   $ sudo cryptsetup open --type luks /dev/mmcblk0p3 data
   ```

   - `data` is the chosen name of the mapper device
   - there is a new device `/dev/mapper/data` with the unencrypted content of `/dev/mmcblk0p3`

5. Format the `/dev/mapper/data` device:

   ```sh
   $ sudo mkfs.ext4 /dev/mapper/data
   ```

6. Show the SD card devices, there is also the new unencrypted `data`:

   ```sh
   $ lsblk
   ...
   mmcblk0       179:0    0 119.1G  0 disk
   ├─mmcblk0p1   179:1    0   256M  0 part  /boot/firmware
   ├─mmcblk0p2   179:2    0    50G  0 part  /
   └─mmcblk0p3   179:3    0  68.8G  0 part
     └─data 253:0    0  68.8G  0 data
   ```

7. Create a mount target under your `<user>` and mount `/dev/mapper/data`:

   ```sh
   $ mkdir ~/data
   $ sudo mount /dev/mapper/data /home/<user>/data
   ```

   - if needed set ownership: `sudo chown <user>:<user> ~/data`

8. Unmount `/dev/mapper/data` from `~/data`:

   ```sh
   sudo umount /home/<user>/data
   #sudo umount /dev/mapper/data
   ```

   - if the device is blocked check with: `sudo lsof /dev/mapper/data` or `sudo lsof /home/<user>/data`

9. Lock (close) the unencrypted partition:

   ```sh
   #sudo cryptsetup luksClose data
   sudo cryptsetup close --type luks data
   ```

10. Show the SD card devices, there is no unencrypted `data`:
    ```sh
    lsblk
    ...
    mmcblk0       179:0    0 119.1G  0 disk
    ├─mmcblk0p1   179:1    0   256M  0 part  /boot/firmware
    ├─mmcblk0p2   179:2    0    50G  0 part  /
    └─mmcblk0p3   179:3    0  68.8G  0 part
    ```

### Daily handling

Activate:

```sh
# unlock with passphrase (unencrypted)
$ sudo cryptsetup open --type luks /dev/mmcblk0p3 data

# mount
$ sudo mount /dev/mapper/data /home/<user>/data
```

Deactivate:

```sh
# unmount
sudo umount /dev/mapper/data

# lock (encrypted)
sudo cryptsetup close --type luks data
```

Notes:

- change passphrase: `sudo cryptsetup luksChangeKey /dev/mmcblk0p3`
- show status: `sudo cryptsetup status /dev/mapper/data` (inactive / active + info)
- manual page: [cryptsetup](https://man7.org/linux/man-pages/man8/cryptsetup.8.html)

### [optional] Move .git-credentials to the protected data folder

If you use `git config --global credential.helper store`, your git credentials are saved as plain text in a local file _~/.git-credentials_.
To protect the credentials move the file to your protected data folder and link it back:

```sh
# mv existing .git-credentials
mv ~/.git-credentials ~/data/.git-credentials
# or create a new empty .git-credentials file
touch ~/data/.git-credentials

# link back to home folder
ln -s $HOME/data/.git-credentials $HOME/.git-credentials
```

## Optimizations (disk i/o, power consuming)

- [Reducing SD Card Wear on a Raspberry Pi or Armbian Device \# Chris Dzombak](https://www.dzombak.com/blog/2021/11/Reducing-SD-Card-Wear-on-a-Raspberry-Pi-or-Armbian-Device.html)
- Disable unneeded services

### Disable unneeded services

- show running services: `sudo systemctl --type=service --state=running`

```sh
# bluetooth
sudo systemctl disable bluetooth.service
sudo systemctl disable hciuart.service
sudo echo "dtoverlay=disable-bt" >> /boot/firmware/config.txt
sudo reboot

# apache2
# manual with:
# - sudo systemctl start|stop|restart apache2
# - sudo systemctl status apache2
sudo systemctl disable apache2
```
