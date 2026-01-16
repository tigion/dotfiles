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
    echo ""
    ;;
  vim)
    echo ""
    ;;
  bash | fish | zsh)
    #     
    # echo ""
    echo ""
    ;;
  git | lazygit)
    #  󰊢   
    echo "󰊢"
    ;;
  ssh)
    # echo ""
    echo ""
    ;;
  *)
    # echo "$1"
    echo "󰣖"
    ;;
esac
