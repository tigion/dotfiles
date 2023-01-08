#!/bin/sh

# TODO:
# - macOS: trigger system and app update
# - Node: npm updates (node -v, npm -v)

# set options
installUpdates=false
if [[ "$1" == "--install" || "$1" == "-i" ]]; then
  installUpdates=true
fi
cleanUp=true

# update Homebrew and installed software
updateHomebrew () {
  if command -v brew &> /dev/null; then
    echo "\nHomebrew:"
    # check
    brew -v
    brew outdated
    # update
    if [[ "$installUpdates" == "true" ]]; then
      brew upgrade
      brew update
    fi
    # clean up
    if [[ "$cleanUp" == "true" ]]; then
      brew autoremove
      brew cleanup -s --prune=14
      #rm -rf $(brew --cache)
      brew doctor
    fi
  fi
}

# update Ruby package manager RubyGems and Gems
updateRuby () {
  if command -v gem &> /dev/null; then
    echo "\nRubyGems, Gems:"
    # check
    currentVersion=`gem --version`
    latestVersion=`curl -s https://api.github.com/repos/rubygems/rubygems/releases | grep -m 1 "html_url" | grep -o "releases/.*/.*" | tr -d "v\"," | cut -d"/" -f3`
    if [[ ${currentVersion//.} -lt ${latestVersion//.} ]]; then
      echo "A new RubyGems version is available ($currentVersion < $latestVersion)"
    else
      echo "RubyGems $currentVersion"
    fi
    gem outdated
    # update
    if [[ "$installUpdates" == "true" ]]; then
      gem update --system
      gem update
    fi
    # clean up
    if [[ "$cleanUP" == "true" ]]; then
      gem cleanup
    fi
  fi
}

# update Python package manager pip
updatePython () {
  if command -v pip3 &> /dev/null; then
    echo "\nPython pip:"
    # check
    pip3 --version
    pip3 list --outdated
    # update
    if [[ "$installUpdates" == "true" ]]; then
      echo "Manualy upgrade each with:"
      echo "pip3 install --upgrade <package name>"
    fi
  fi
}

updateHomebrew
updateRuby
updatePython
