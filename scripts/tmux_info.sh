#!/usr/bin/env bash

echo "tmux version:         $(tmux -V)"
echo "platform:             $(uname -sp)"

echo "pane_key_mode:        $(tmux display -p '#{pane_key_mode}')"
echo "client_termtype:      $(tmux display -p '#{client_termtype}')"
echo "extended-keys:        $(tmux display -p '#{extended-keys}')"
echo "extended-keys-format: $(tmux display -p '#{extended-keys-format}')"

echo "echo \$TERM:           ${TERM}"
echo "tput colors:          $(tput colors)"
echo "tput longname:        $(tput longname)"
