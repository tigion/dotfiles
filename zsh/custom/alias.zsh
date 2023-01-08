# --- Aliases ---

# open tree without .git folder and ignored files
alias tree="tree -a -I '.git' --gitignore --dirsfirst"

# open todo note in Bear.app
alias todo="bear open-todo"

# recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# ...
alias ti-clock="printf '\e[8;11;48t'; tty-clock -c -C3 -f '%A %d.%m.%Y'"
