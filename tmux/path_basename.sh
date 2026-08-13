#!/usr/bin/env bash
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

path=${1:-"-"}

if [[ $path == /* ]]; then
  home=$(realpath "$HOME" 2>/dev/null) || home=$HOME
  if [[ $path == "$home" || $path == "$home"/* ]]; then
    path=~${path#"$home"}
  fi
fi

basename -- "${path}"
