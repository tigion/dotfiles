#!/bin/bash

# ...
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}
user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}
skip () {
  printf "\r\033[2K  [\033[0;33mSKIP\033[0m] $1\n"
}
fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# ...
showOptions () {
  no="\033[0;31mNo\033[0m"
  yes="\033[00;32mYes\033[0m"
  
  info "--- Options ---"
  
  if [[ "$INSTALL_SOFTWARE" == "true" ]]; then status="$yes"; else status="$no"; fi
  info "Install software: $status"

  if [[ "$INSTALL_CONFIG" == "true" ]]; then status="$yes"; else status="$no"; fi
  info "Install configurations: $status"
  
  if [[ "$INSTALL_CONFIG" == "true" ]]; then
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then status="$yes"; else status="$no"; fi
    info "- Overwrite existing ones: $status"
  
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then status="$yes"; else status="$no"; fi
      info "- Backup existing ones: $status"
      info "- Backup timestamp: $BACKUP_TIMESTAMP"

      if [[ "$BACKUP_EXISTING_CONFIG" == "true" ]]; then
        if [[ "$BACKUP_EXISTING_CONFIG_LINK" == "true" ]]; then status="$yes"; else status="$no"; fi
        info "- Backup symbolic links: $status"
      fi
    else
      if [[ "$SKIP_EXISTING_CONFIG" == "true" ]]; then status="$yes"; else status="$no"; fi
      info "- Skip existing config: $status"
    fi
  fi
}

# ...
getConfigType () {
  if [[ -h "$1" ]]; then
    if [[ -e  "$1" ]]; then
      echo "link"
    else
      echo "!link"
    fi
  elif [[ -f "$1" ]]; then
    echo "file"
  elif [[ -d "$1" ]]; then
    echo "directory"
  else
    echo "-"
  fi
}

# ...
link () {
  declare src="$1" dst="$2"
  declare srcType=$(getConfigType "$src")
  declare dstType=$(getConfigType "$dst")

  # handle non-existent source or empty target
  if [[ ! -e "$src" ]]; then
    skip "Source '$src' does not exist"
    return 0
  elif [[ -z "$dst" ]]; then
    skip "Target '$dst' for source '$src' is empty"
    return 0
  fi

  # handle existing configuration
  # -e ... file exists (can be a file, directory or symbolic link)
  # -h ... symbolic link exists, but can be a non-existent file,
  #        if a link exists to a target that no longer exists
  if [[ -e "$dst" || -h "$dst" ]]; then
    # overwrite
    if [[ "$OVERWRITE_EXISTING_CONFIG" == "true" ]]; then
      # set backup state, with special handling of symbolic links
      local doBackup="$BACKUP_EXISTING_CONFIG"
      if [[ -h "$dst" && "$BACKUP_EXISTING_CONFIG_LINK" == "false" ]]; then
        doBackup=false
      fi

      if [[ "$doBackup" == "true" ]]; then
        # remove with backup
        dstBackup="${dst}.backup-${BACKUP_TIMESTAMP}"
        mv "$dst" "$dstBackup"
        success "Moved existing $dstType '$dst' to '$dstBackup'"
      else
        # remove without backup
        rm -rf "$dst"
        success "Removed existing $dstType '$dst'"
      fi
    else
      if [[ "$SKIP_EXISTING_CONFIG" == "true" ]]; then
        # skip
        skip "$dstType '$dst' already exists"
      else
        # fail: the installation script stops 
        fail "$dstType '$dst' already exists"
      fi
    fi
  fi

  # create link
  local folder=$(dirname "$dst")
  if ! [[ -d "$folder" ]]; then
    mkdir -p "$folder"
    success "Created directory '$folder'"
  fi
  ln -s "$src" "$dst"
  success "Linked $srcType '$src' to '$dst'"
}
