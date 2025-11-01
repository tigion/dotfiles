#!/usr/bin/env bash

# Starts kitty as new single instance in fullscreen with:
# - custom background image
# - custom instance group
# - custom base directory
# - options:
#   - tmux: run tmux session script

# dir="${HOME}/dojo/"
dir="${HOME}/projects/"
group="project"
o1="background_image=${HOME}/.config/kitty/backgrounds/background_01.png"
o2="background_image_layout=scaled"
o3="background_tint=0.985"

cmd=""
if [[ $1 == "tmux" ]]; then
  cmd="tmux-session HOME DEV HTWD"
fi

if [[ -n $cmd ]]; then
  kitty --start-as fullscreen --single-instance --instance-group "$group" --directory="$dir" -o "$o1" -o "$o2" -o "$o3" --hold zsh -c "$cmd" &>/dev/null &
else
  kitty --start-as fullscreen --single-instance --instance-group "$group" --directory="$dir" -o "$o1" -o "$o2" -o "$o3" &>/dev/null &
fi
