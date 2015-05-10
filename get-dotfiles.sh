#!/bin/sh

################################################################################
#
# Shell script to copy important configuration files from the current
# environment to this repository.
#
################################################################################

# Exit as soon as a command fails
set -e

# Accessing an empty variable will yield an error
set -u

# Assume the working directory is the path to the dotfiles repository
REPO_PATH="$PWD/"

# Abort mission when we’re not in a git repository
if [[ ! -d .git ]] || ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git repository."
    exit 1
fi



# Detect OS (OS X, Linux or Windows)
if [ "$(uname)" = "Darwin" ]; then
    echo "Detected system: OS X"

    OS="osx/"

    ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    echo "Detected system: Linux"

    OS="linux/"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    echo "Detected system: Windows"

    OS="win/"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User/"
    NPM_DIR="$HOME/AppData/Roaming/npm/node_modules/npm/"
fi

# Adjust destination paths so the files are separated by OS
BASH_DEST="${REPO_PATH}${OS}bash/"
GIT_DEST="${REPO_PATH}${OS}git/"
NPM_DEST="${REPO_PATH}${OS}npm/"
RUBY_DEST="${REPO_PATH}${OS}ruby/"
ST_DEST="${REPO_PATH}${OS}sublime-text/"

declare -a destinations=($BASH_DEST $GIT_DEST $NPM_DEST $RUBY_DEST $ST_DEST)

for dest in "${destinations[@]}"; do
    mkdir -p "$dest"
done



# Bash
cp "$HOME/.bashrc" "$BASH_DEST"
cp "$HOME/.bash_aliases" "$BASH_DEST"

# Git
cp "$HOME/.gitignore_global" "$GIT_DEST"
cp "$HOME/.gitconfig" "$GIT_DEST"

# Node.js/npm
cp "${NPM_DIR}.npmrc" "$NPM_DEST"

# Ruby/RubyGems
cp "$HOME/.gemrc" "$RUBY_DEST"

# Sublime Text
cp "${ST_DIR}Preferences.sublime-settings" "$ST_DEST"
cp "${ST_DIR}Package Control.sublime-settings" "$ST_DEST"
cp "${ST_DIR}For Loop (range).sublime-snippet" "$ST_DEST"
cp "${ST_DIR}Fraction (TeX).sublime-snippet" "$ST_DEST"



# OS specific copy operations
if [ "$OS" = "osx/" ]; then
    echo "Nothing here."
elif [ "$OS" = "linux/" ]; then
    cp "${ST_DIR}Default (Linux).sublime-keymap" "$ST_DEST"
elif [ "$OS" = "windows/" ]; then
    cp "${ST_DIR}Default (Windows).sublime-keymap" "$ST_DEST"
fi

echo "Completed."
