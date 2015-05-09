#!/bin/sh

# Shell script to copy important configuration files from the current
# environment to this repository.

# Exit as soon as a command fails
set -e

# Accessing an empty variable will yield an error
set -u



# Local location of the repository
REPO_PATH="$HOME/dev/repos/dotfiles/"

# Exit when $REPO_PATH is not a git repository
if [ ! -d "$REPO_PATH/.git" ]; then
  echo "${REPO_PATH} is not a git repository."
  exit 1
fi



# Detect OS (OS X, Linux or Windows)
if [ "$(uname)" = "Darwin" ]; then
    echo "System: OS X"

    OS_PATH="osx/"

    ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    echo "System: Linux"

    OS_PATH="linux/"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    echo "System: Windows"

    OS_PATH="win/"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User/"
    NPM_DIR="$HOME/AppData/Roaming/npm/node_modules/npm/"
fi

# Adjust destination paths so the files are separated by OS
BASH_DEST="${REPO_PATH}${OS_PATH}bash/"
GIT_DEST="${REPO_PATH}${OS_PATH}git/"
NPM_DEST="${REPO_PATH}${OS_PATH}npm/"
RUBY_DEST="${REPO_PATH}${OS_PATH}ruby/"
ST_DEST="${REPO_PATH}${OS_PATH}sublime-text/"

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
if [ "$OS_PATH" = "osx/" ]; then
    echo "Nothing here."
elif [ "$OS_PATH" = "linux/" ]; then
    cp "${ST_DIR}Default (Linux).sublime-keymap" "$ST_DEST"
elif [ "$OS_PATH" = "windows/" ]; then
    cp "${ST_DIR}Default (Windows).sublime-keymap" "$ST_DEST"
fi

echo "Completed."
