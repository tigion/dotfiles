#!/bin/bash

encrypted_device="/dev/mmcblk0p3"
mapper_device_name="data"
mapper_device="/dev/mapper/${mapper_device_name}"
mount_folder="$HOME/data"

sudo umount "$mount_folder" && echo "'${mount_folder}' is now unmounted" ||
  (sudo lsof "$mount_folder" && printf "\nNote: if COMMAND 'gitstatus' -> close the zsh shell, because zsh keeps a connection to gitstatus or kill the PID with 'kill -15 [PID]' (if not more needed)\n\n")
sudo cryptsetup close --type luks "$mapper_device_name" && echo "'${mapper_device}' is removed and ${encrypted_device}' is now locked"