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
    echo "${REPO_PATH} is not a git repository."
    echo "Please run the script from the root of the repository you want to store your files in."
    exit 1
fi



# Detect OS (OS X, Linux or Windows)
printf "Detecting system: "
uname=$(uname -s)
case "$uname" in
    Darwin )
        printf "OS X"
        OS="osx"
        ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
        ;;
    *Linux* )
        printf "Linux"
        OS="linux"
        ST_DIR="$HOME/.config/sublime-text-3/Packages/User"
        ;;
    *MINGW32_NT* )
        printf "Windows"
        OS="win"
        ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User"
        NPM_DIR="$HOME/AppData/Roaming/npm/node_modules/npm"
        ;;
    * )
        printf "Could not detect operating system. Aborting."
        exit 2
        ;;
esac
printf "\n"

# Adjust destination paths so the files are separated by OS
BASH_DEST="${REPO_PATH}/${OS}/bash/"
GIT_DEST="${REPO_PATH}/${OS}/git/"
NPM_DEST="${REPO_PATH}/${OS}/npm/"
RUBY_DEST="${REPO_PATH}/${OS}/ruby/"
ST_DEST="${REPO_PATH}/${OS}/sublime-text/"

# Put the destination paths inside an array …
declare -a destinations=(
    "$BASH_DEST"
    "$GIT_DEST"
    "$NPM_DEST"
    "$RUBY_DEST"
    "$ST_DEST"
)

# … and create the necessary destination directories if they don’t exist already
for dest in "${destinations[@]}"; do
    mkdir -p "$dest"
done



echo "Copying files ..."
# Bash
cp -u "$HOME/".bashrc "$BASH_DEST"
cp -u "$HOME/".bash_aliases "$BASH_DEST"

# Git
cp -u "$HOME/".gitignore_global "$GIT_DEST"
cp -u "$HOME/".gitconfig "$GIT_DEST"

# Ruby/RubyGems
cp -u "$HOME/".gemrc "$RUBY_DEST"

# Sublime Text
cp -u "${ST_DIR}/"*.sublime-settings "$ST_DEST"
cp -Ru "${ST_DIR}/snippets/" "$ST_DEST"




# OS specific copy operations
case "$OS" in
    # "osx")
    #     echo "Nothing here."
    #     ;;
    "linux")
        cp -u "${ST_DIR}/Default (Linux).sublime-keymap" "$ST_DEST"
        ;;
    "windows")
        cp -u "${NPM_DIR}/".npmrc "$NPM_DEST"
        cp -u "${ST_DIR}/Default (Windows).sublime-keymap" "$ST_DEST"
        ;;
esac

echo "Completed."
