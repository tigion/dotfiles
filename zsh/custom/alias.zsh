# --- Aliases ---

# open tree without .git folder and ignored files, follow symbolic links
alias tree="tree -a -l -I '.git' --gitignore --dirsfirst"

# echo PATH variable line by line
alias echoPATH="echo '${PATH//:/\\n}'"

# open tty-clock with my preferred settings
alias ti-clock="tty-clock -c -C3 -f '%A %d.%m.%Y'"

# Lazygit
alias lg="lazygit"

# -- macOS --

# recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# quickly lock or put the Mac to sleep
# System Settings -> Lock Screen -> Require password to wake this computer from sleep or screensaver -> immediately 
alias afk="open -a ScreenSaverEngine.app"
#alias afk="pmset displaysleepnow"
alias slp="pmset sleepnow"

# open todo note in Bear.app
alias todo="bear open-todo"
