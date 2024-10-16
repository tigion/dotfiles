# --- Aliases ---

# open colored tree without .git folder and ignored files, follow symbolic links
# alias tree='tree -a -l -C -I ".git" --gitignore --dirsfirst'
alias tree='tree -a -l -C -I ".git" --dirsfirst'

# echo PATH variable line by line
alias echoPATH='echo "${PATH//:/\\n}"'

# (fuzzy) search
alias öh='history | sort --reverse | cut -c 8- | fzf --tmux --border-label="  History "'
alias öa='alias | fzf --tmux --border-label="  Aliases "'
# Searches for directories and files in the current directory and cd into it.
# alias öd='tmp=$(find . -type d \( -path "*/.*" -o -path "./Library" -o -path "*/node_modules" \) -prune -o -type d -print | fzf) && cd "$tmp"'
# alias öf='tmp=$(find . -type d \( -path "*/.*" -o -path "./Library" -o -path "*/node_modules" \) -prune -o -type f -print | fzf) && cd $(dirname "$tmp")'
alias öd='tmp=$(fzf --tmux --border-label="  Directories " --walker dir,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd "$tmp"'
alias öD='tmp=$(fzf --tmux --border-label="  Directories (~/) " --walker-root="$HOME" --walker dir,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd "$tmp"'
alias öf='tmp=$(fzf --tmux --border-label="  Files " --walker file,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd $(dirname "$tmp")'
alias öF='tmp=$(fzf --tmux --border-label="  Files (~/) " --walker-root="$HOME" --walker file,follow,hidden --walker-skip .git,node_modules,target,.venv,Library,Applications) && cd $(dirname "$tmp")'

# replacements
alias cat='bat -p'
alias ls2='eza --icons'
# alias tree='eza --tree -a -I .git --group-directories-first --icons'
alias tree2='eza --tree -L 2 -a -I .git --group-directories-first --icons'

# shortcuts
alias lg='lazygit'
alias clock='tty-clock -c -C3 -f "%A %d.%m.%Y"'

# Python
# virtual environment
alias vc='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias vd='deactivate'
alias vu='pip freeze --require-virtualenv | cut -d'=' -f1 | xargs -n1 pip install -U'

# -- macOS --

# recursively delete `.DS_Store` files
alias cleanup='find . -name "*.DS_Store" -type f -ls -delete'

# quickly lock or put the Mac to sleep
# System Settings -> Lock Screen -> Require password to wake this computer from sleep or screensaver -> immediately
alias afk='open -a ScreenSaverEngine.app'
#alias afk="pmset displaysleepnow"
alias slp='pmset sleepnow'

# open todo note in Bear.app
alias todo='bear open-todo'
