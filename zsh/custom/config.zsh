# --- Zsh ---

setopt noautocd # don't change directory without `cd`

# Command History
export HISTFILE=~/.zsh_history # history file
export HISTFILESIZE=1000000000 # history file size
export HISTSIZE=1000000000     # history size
setopt INC_APPEND_HISTORY      # immediately add commands to history
#export HISTTIMEFORMAT="[%F %T] " # timestamp format
setopt HIST_FIND_NO_DUPS      # skip duplicate commands
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt HIST_IGNORE_ALL_DUPS   # delete all duplicates
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# set own COMPDUMP path (default is ~/)
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# user config folder
export XDG_CONFIG_HOME="$HOME/.config"

# cd Paths
#export cdpath=($HOME/code)

# --- Paths ---

# --- Homebrew ---
if _is_cmd "brew" || _has_brew; then
  # get Homebrew installation path
  _is_cmd "brew" && homebrew_path=$(brew --prefix) || homebrew_path=$(_brew_prefix)

  # --- Homebrew bin & sbin ---
  _add_path "$homebrew_path/bin"
  _add_path "$homebrew_path/sbin"

  # --- Ruby ---
  _add_path "${homebrew_path}/opt/ruby/bin"
  _add_path "$(gem environment gemdir)/bin"
  _add_path "$(ruby -e 'print Gem.user_dir')/bin"

  # --- Java ---
  _add_path "${homebrew_path}/opt/openjdk/bin"

  unset homebrew_path
fi

# add ~/bin
_add_path "$HOME/bin"

# clean up duplicates in $PATH (zsh feature)
typeset -U path

# --- Terminfo ---
if _is_macos; then
  terminfo_folder="$HOME/.local/share/terminfo"
  if [[ -d "$terminfo_folder" && ! "$TERMINFO_DIRS" =~ (^|:)$terminfo_folder(:|$) ]]; then
    export TERMINFO_DIRS=$TERMINFO_DIRS:$terminfo_folder
  fi
fi

# --- fzf ---
eval "$(fzf --zsh)"
bindkey "ç" fzf-cd-widget # Workaround for `option/alt+c` to cd selected folder
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
