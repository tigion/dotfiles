# --- Zsh ---
# Command History
export HISTFILE=~/.zsh_history # history file
export HISTFILESIZE=1000000000 # history file size
export HISTSIZE=1000000000 # history size
setopt INC_APPEND_HISTORY # immediately add commands to history
#export HISTTIMEFORMAT="[%F %T] " # timestamp format
setopt HIST_FIND_NO_DUPS # skip duplicate commands
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt HIST_IGNORE_ALL_DUPS   # delete all duplicates
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
# set own COMPDUMP path (default is ~/)
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# --- user config folder ---
export XDG_CONFIG_HOME="$HOME/.config"

# --- CD Paths ---
#export cdpath=($HOME/code)

# --- helper ---
add_path() {
  # if [[ -d "$1" && ! "$PATH" =~ (^|:)$1(:|$) ]]; then
  # deactivated because:
  # - add new paths in front
  # - remove duplicates later with `typeset -U path` to prevent unwanted reordering
  if [[ -d "$1" ]]; then
    export PATH="$1:$PATH"
  fi
}

# --- Paths ---
# ~/bin
add_path "$HOME/bin"


# macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  # --- Terminfo ---
  terminfo_folder="$HOME/.local/share/terminfo"
  if [[ -d "$terminfo_folder" && ! "$TERMINFO_DIRS" =~ (^|:)$terminfo_folder(:|$) ]]; then
    export TERMINFO_DIRS=$TERMINFO_DIRS:$terminfo_folder
  fi

  # --- Homebrew ---
  add_path "/usr/local/sbin"

  # --- Ruby ---
  if [[ "$(uname -m)" = "arm64" ]]; then
    # arm64 (apple)
    add_path "/opt/homebrew/opt/ruby/bin"
  elif [[ "$(uname -m)" = "x86_64" ]]; then
    # x86_64 (intel)
    add_path "/usr/local/opt/ruby/bin"
  fi
  add_path "$(gem environment gemdir)/bin"

  # --- Java ---
  if [ "$(uname -m)" = "arm64" ]; then
    add_path "/opt/homebrew/opt/openjdk/bin"
  elif [ "$(uname -m)" = "x86_64" ]; then
    add_path "/usr/local/opt/openjdk/bin"
  fi
fi

# clean up duplicates in $PATH (zsh feature)
typeset -U path

# --- fzf ---
eval "$(fzf --zsh)"
bindkey "ç" fzf-cd-widget # Workaround for `option/alt+c` to cd selected folder
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
