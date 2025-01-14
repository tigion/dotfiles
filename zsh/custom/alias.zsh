# --- Helpers ---

# Check if a command exists
is_cmd() {
  type "$1" >/dev/null 2>&1
}

# Check if in a python venv
is_venv() {
  if [[ ! -n "$VIRTUAL_ENV" ]]; then echo "Not in activated python venv"; fi
  [[ -n "$VIRTUAL_ENV" ]]
}

# --- Aliases ---

# source zsh config
alias reload='
  printf "cleanup aliases ... ";
  unalias -a;
  printf "done\nsource .zshrc ... ";
  source ~/.zshrc; echo "done"'

# echo PATH variable line by line
alias path='echo "${PATH//:/\\n}"'

# open colored tree without .git folder, follow symbolic links
alias tree='tree -a -l -C -I ".git" --dirsfirst'

# eza
if is_cmd 'eza'; then
  # defaults
  alias eza='eza --group --group-directories-first --icons'
  # shortcuts
  alias ll='eza -l'
  alias lt='eza --tree --all --ignore-glob=.git'
  alias lt1='lt --level=1'
  alias lt2='lt --level=2'
  alias lt3='lt --level=3'
  # replacements
  alias ls='eza'
fi

# bat
if is_cmd 'bat'; then
  # replacements
  alias cat='bat -pp'
fi

# lazygit
if is_cmd 'lazygit'; then
  # shortcuts
  alias lg='lazygit'
fi

# tty-clock
if is_cmd 'tty-clock'; then
  # shortcuts
  alias clock='tty-clock -c -C3 -f "%A %d.%m.%Y"'
fi

# fzf (fuzzy) search
if is_cmd 'fzf'; then
  alias öh='history | cut -c 8- | fzf --scheme=history --tac --tmux --border-label="  History "'
  alias öa='alias | fzf --tmux --border-label="  Aliases "'
  # Searches for directories and files in the current directory and cd into it.
  alias öd='tmp=$(fzf --tmux --border-label="  Directories " --walker dir,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd "$tmp"'
  # alias öd='tmp=$(find . -type d \( -path "*/.*" -o -path "./Library" -o -path "*/node_modules" \) -prune -o -type d -print | fzf) && cd "$tmp"'
  alias öD='tmp=$(fzf --tmux --border-label="  Directories (~/) " --walker-root="$HOME" --walker dir,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd "$tmp"'
  alias öf='tmp=$(fzf --tmux --border-label="  Files " --walker file,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd $(dirname "$tmp")'
  # alias öf='tmp=$(find . -type d \( -path "*/.*" -o -path "./Library" -o -path "*/node_modules" \) -prune -o -type f -print | fzf) && cd $(dirname "$tmp")'
  alias öF='tmp=$(fzf --tmux --border-label="  Files (~/) " --walker-root="$HOME" --walker file,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd $(dirname "$tmp")'
fi

# -- Python --

# virtual environment
alias vc='python3 -m venv .venv && echo "Python venv is created."'
alias va='source .venv/bin/activate && echo "Python venv is activated."'
alias vd='if is_venv; then deactivate; echo "Python venv is deactivated."; fi'
alias vi='if is_venv; then pip install -r requirements.txt; fi'
alias vl='is_venv && pip list'
alias vo='is_venv && pip list --outdated'
alias vu='is_venv && pip freeze --require-virtualenv | cut -d'=' -f1 | xargs -n1 pip install -U'

# -- macOS --

# recursively delete `.DS_Store` files
alias cleanup='find . -name "*.DS_Store" -type f -ls -delete'

# quickly lock or put the Mac to sleep
# System Settings -> Lock Screen -> Require password to wake this computer from sleep or screensaver -> immediately
alias afk='open -a ScreenSaverEngine.app'
#alias afk="pmset displaysleepnow"
alias slp='pmset sleepnow'
