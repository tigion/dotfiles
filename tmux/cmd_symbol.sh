#!/usr/bin/env bash
# Returns a symbol for the given command name.
# If no symbol is found, it returns the command name.
# - $1: command name
#
# - `zsh` -> ``
# - `foo` -> `foo` or `󰣖`
#
# Replace `#{b:pane_current_command}` in tmux.conf with
# `#(~/.config/tmux/cmd_symbol.sh #{b:pane_current_command})`

case "$1" in
  nvim)
    printf '%s\n' ""
    ;;
  vim)
    printf '%s\n' ""
    ;;
  bash | fish | zsh)
    #     
    printf '%s\n' ""
    ;;
  git | lazygit)
    #  󰊢   
    printf '%s\n' "󰊢"
    ;;
  ssh)
    #  
    printf '%s\n' ""
    ;;
  *)
    # printf '%s\n' "$1"
    printf '%s\n' "󰣖"
    ;;
esac
