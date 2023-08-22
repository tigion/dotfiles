#!/bin/bash
# Replace $HOME with '~' and print basename
# - $1: path to process (pane_current_path)
#
# - `/home/user/foo` -> `~`
# - `/home/user/foo/bar` -> `bar`
# - `~/` -> `~`
# - `~/bar` -> `bar`
# - `home/user/foo` -> `foo`
# - `` -> `-`
#
# Replace `#{b:pane_current_path}` in tmux.conf with
# `#(~/.config/tmux/path_basename.sh #{pane_current_path})`

[[ -n $1 ]] && path=$1 || path="-"

if [[ ${path::1} == "/" ]]; then
  path=~${path#"$HOME"}
fi

basename "${path}"