#!/bin/bash

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
REPO_PATH="$PWD"

# Abort mission when we’re not in a git repository
if [[ ! -d .git ]] || ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git repository."
    exit 1
fi



# Detect OS (OS X, Linux or Windows)
printf "Detecting system: "
uname=$(uname -s)
if [[ $uname = Darwin ]]; then
    printf "OS X"

    OS="osx"

    ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
elif [[ $uname = *Linux* ]]; then
    printf "Linux"

    OS="linux"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User/"
elif [[ $uname = *MINGW32_NT* ]]; then
    printf "Windows"

    OS="win"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User/"
    NPM_DIR="$HOME/AppData/Roaming/npm/node_modules/npm/"
else
    printf "Could not detect system. Aborting."
    exit 2
fi
printf "\n"

# Adjust destination paths so the files are separated by OS
BASH_DEST="${REPO_PATH}/${OS}/bash/"
GIT_DEST="${REPO_PATH}/${OS}/git/"
NPM_DEST="${REPO_PATH}/${OS}/npm/"
RUBY_DEST="${REPO_PATH}/${OS}/ruby/"
ST_DEST="${REPO_PATH}/${OS}/sublime-text/"

declare -a destinations=("$BASH_DEST" "$GIT_DEST" "$NPM_DEST" "$RUBY_DEST" "$ST_DEST")

for dest in "${destinations[@]}"; do
    mkdir -p "$dest"
done



echo "Copying files"
# Bash
printf "Bash "
cp "$HOME/.bashrc" "$BASH_DEST"; printf "."
cp "$HOME/.bash_aliases" "$BASH_DEST"; printf "."
printf "\n"

# Git
printf "Git "
cp "$HOME/.gitignore_global" "$GIT_DEST"; printf "."
cp "$HOME/.gitconfig" "$GIT_DEST"; printf "."
printf "\n"

# Ruby/RubyGems
printf "Ruby "
cp "$HOME/.gemrc" "$RUBY_DEST"; printf "."
printf "\n"

# Sublime Text
printf "Sublime Text "
cp "${ST_DIR}Preferences.sublime-settings" "$ST_DEST"; printf "."
cp "${ST_DIR}Markdown.sublime-settings" "$ST_DEST"; printf "."
cp "${ST_DIR}YAML.sublime-settings" "$ST_DEST"; printf "."
cp "${ST_DIR}Package Control.sublime-settings" "$ST_DEST"; printf "."
cp "${ST_DIR}For Loop (range).sublime-snippet" "$ST_DEST"; printf "."
cp "${ST_DIR}Fraction (TeX).sublime-snippet" "$ST_DEST"; printf "."
printf "\n"



# OS specific copy operations
if [ "$OS" = "osx" ]; then
    echo "Nothing here."
elif [ "$OS" = "linux" ]; then
    cp "${ST_DIR}Default (Linux).sublime-keymap" "$ST_DEST"
elif [ "$OS" = "windows" ]; then
    cp "${NPM_DIR}.npmrc" "$NPM_DEST"
    cp "${ST_DIR}Default (Windows).sublime-keymap" "$ST_DEST"
fi

echo "Completed."
