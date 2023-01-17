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
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
# set own COMPDUMP path (default is ~/) 
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# --- CD Paths ---
#export cdpath=($HOME/code)

# --- Paths ---
# ~/bin
export PATH="$HOME/bin:$PATH"

# --- Homebrew ---
newPath="/usr/local/sbin"
if [[ -d "$newPath" ]]; then
  [[ ! "$PATH" =~ $newPath ]] && export PATH="$newPath:$PATH"
fi

# --- Ruby ---
if [ `uname -m` = "arm64" ] && [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  # arm64 (apple)
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH=`gem environment gemdir`/bin:$PATH
elif [ `uname -m` = "x86_64" ] && [ -d "/usr/local/opt/ruby/bin" ]; then
  # x86_64 (intel)
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# --- Lazygit---
export XDG_CONFIG_HOME="$HOME/.config"
