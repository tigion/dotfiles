#!/usr/bin/env bash
#
# Opens Ghostty.app with:
# - new window
# - toggle full screen
# - options:
#   - tmux: run tmux session script

app="/Applications/Ghostty.app"

# Checks if the required app is installed
if [ ! -d "$app" ]; then
  echo "The required '${app}' is not installed."
  exit 1
fi

# AppleScript to open Ghostty.app in fullscreen
osascript <<EOS
-- Brings app to the front, launching it if necessary
activate application "Ghostty"
delay 0.5

tell application "System Events"
  -- Opens a new app window and toggles full screen
  tell application process "Ghostty"
    keystroke "n" using {command down}
    -- click menu item "New Window" of menu "File" of menu bar 1
    delay 0.5
    click menu item "Toggle Full Screen" of menu "Window" of menu bar 1
    -- click menu item "Top Left" of menu 1 of menu item "Move & Resize" of menu "Window" of menu bar 1
    delay 0.5
  end tell

  -- Run command if app is frontmost and tmux is given as argument
  set frontApp to first application process whose frontmost is true
  set frontAppName to name of frontApp
  if frontAppName is "Ghostty"
    keystroke "cd"  -- Send cmd
    key code 36  -- Send return
    delay 0.5
    if "$1" is "tmux" then
      keystroke "tmux-session HOME DEV HTWD"  -- Send cmd
      key code 36  -- Send return
    end
  end
end tell
EOS
