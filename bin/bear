#!/usr/bin/env bash
#
# Opens or create a note via callback URL with defined
# size and position in Bear, a note app for macOS.

# Checks if the required Bear.app is installed
if [ ! -d "/Applications/Bear.app" ]; then
  echo "The required Bear.app is not installed."
  exit 1
fi

command="$1"
parameter="$2"

BEAR_URL="bear://x-callback-url"

# Encodes string for url
#
# FIX: This encodes not correctly `ä` and `☕️`
#
# https://gist.github.com/cdown/1163649?permalink_comment_id=4292547#gistcomment-4292547
raw_url_encode() {
  # local LC_ALL=C
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for ((pos = 0; pos < strlen; pos++)); do
    c=${string:$pos:1}
    case "$c" in
      [-_.~a-zA-Z0-9]) o="${c}" ;;
      *) printf -v o '%%%02x' "'$c" ;;
    esac
    encoded+="${o}"
  done
  echo "${encoded}"
}

# Creates new note with title
create_note() {
  if [[ -z "$1" ]]; then
    echo "Invalid note title!"
    exit 1
  fi
  local title && title=$(raw_url_encode "$1")
  local args="&open_note=yes&new_window=yes&edit=yes"
  local callback_url="${BEAR_URL}/create?title=${title}${args}"
  echo "$callback_url"
}

# Opens note via id
open_note_by_id() {
  local id="$1"
  local rx="^[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}-[A-Z0-9]{5}-[A-Z0-9]{16}$"
  local args="&open_note=yes&new_window=yes"
  if [[ ! "$id" =~ $rx ]]; then
    echo "Invalid note id!"
    exit 1
  fi
  local callback_url="${BEAR_URL}/open-note?id=${id}"
  echo "$callback_url"
}

# Opens note via title
open_note_by_title() {
  if [[ -z "$1" ]]; then
    echo "Invalid note title!"
    exit 1
  fi
  local title
  if [[ "$2" == "--no-url-encode" ]]; then
    title="$1"
  else
    title=$(raw_url_encode "$1")
  fi
  local args="&exclude_trashed=yes&open_note=yes&new_window=yes&edit=no"
  local error_callback_url="${BEAR_URL}/create?title=${title}${args}"
  local args_error && args_error="&x-error=$(raw_url_encode "$error_callback_url")"
  local callback_url="${BEAR_URL}/open-note?title=${title}${args}${args_error}"
  echo "$callback_url"
}

# Opens TODO note via title or create new one
open_todo() {
  open_note_by_title "TODO"
}

# Opens Vim note via title or create new one
open_vim() {
  # open_note_by_title "☕️ Vim - CheatSheet"
  open_note_by_title "%E2%98%95%EF%B8%8F%20Vim%20-%20CheatSheet" --no-url-encode
}

# Gets the command based callback url
callback_url=""
if [[ "$command" == "create" ]]; then
  callback_url=$(create_note "$parameter")
elif [[ "$command" == "note" ]]; then
  callback_url=$(open_note "$parameter")
elif [[ "$command" == "todo" ]]; then
  callback_url=$(open_todo)
elif [[ "$command" == "vim" ]]; then
  callback_url=$(open_vim)
else
  echo "TODO: Nothing to do"
  exit 1
fi

# Opens bear via callback url
open "$callback_url"

# Sets the window position and size
osascript <<EOS
  tell application "System Events"
    set appWindow to the front window of application process "Bear"

    -- get size of screen
    get the size of scroll area 1 of application process "Finder"
    set Display to {width:item 1, height:item 2} of the result

    -- set app window to max size
    set position of appWindow to [0, 0]
    set size of appWindow to [the Display's width, the Display's height]

    -- get app window position and size
    set [_w, _h] to the size of appWindow
    set [_x, _y] to the position of appWindow

    -- set final position and size
    set position of appWindow to [_x + 25, _y + 25]
    set the size of appWindow to [550, _h -50]
  end tell
EOS
