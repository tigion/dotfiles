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

# Needs special handling, because `brew` might be installed but not in PATH yet.
_has_brew() {
  # check default installation paths
  [[ -x "/usr/local/bin/brew" || -x "/opt/homebrew/bin/brew" || -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]
}

_brew_prefix() {
  if [[ -x "/usr/local/bin/brew" ]]; then
    echo "/usr/local"
  elif [[ -x "/opt/homebrew/bin/brew" ]]; then
    echo "/opt/homebrew"
  elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    echo "/home/linuxbrew/.linuxbrew"
  fi
  echo ""
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
