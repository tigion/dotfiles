#!/bin/bash

encrypted_device="/dev/mmcblk0p3"
mapper_device_name="data"
mapper_device="/dev/mapper/${mapper_device_name}"
mount_folder="$HOME/data"

sudo cryptsetup open --type luks "$encrypted_device" "$mapper_device_name" &&
  echo "'${encrypted_device}' is now unlocked to '${mapper_device}'"

sudo mount "${mapper_device}" "$mount_folder" &&
  echo "'${mapper_device}' is now mounted to '${mount_folder}'"