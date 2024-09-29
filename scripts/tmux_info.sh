#!/usr/bin/env bash

echo "pane_key_mode:        $(tmux display -p '#{pane_key_mode}')"
echo "client_termtype:      $(tmux display -p '#{client_termtype}')"
echo "extended-keys:        $(tmux display -p '#{extended-keys}')"
echo "extended-keys-format: $(tmux display -p '#{extended-keys-format}')"
