# --- Helper ---

# Checks if the OS is macOS.
_is_macos() {
  [[ $OSTYPE == darwin* ]]
}

# Checks if the OS is Linux.
_is_linux() {
  # [[ $OSTYPE == linux* ]]
  [[ "$OSTYPE" == "linux-gnu"* ]]
}

# Checks if the OS is Ubuntu.
_is_ubuntu() {
  [[ _is_Linux ]] || return 1
  [[ -f /etc/os-release ]] || return 1
  . /etc/os-release
  [[ "$ID" == "ubuntu" ]]
}

# Checks if a command exists.
_is_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# Checks if we are in an activated python virtual environment.
_is_venv() {
  if [[ ! -n "$VIRTUAL_ENV" ]]; then echo "Not in activated python venv"; fi
  [[ -n "$VIRTUAL_ENV" ]]
}

# Adds a directory to the PATH.
_add_path() {
  # if [[ -d "$1" && ! "$PATH" =~ (^|:)$1(:|$) ]]; then
  # deactivated because:
  # - add new paths in front
  # - remove duplicates later with `typeset -U path` to prevent unwanted reordering
  if [[ -d "$1" ]]; then
    export PATH="$1:$PATH"
  else
    echo "Directory $1 does not exist, not adding to PATH."
  fi
}
