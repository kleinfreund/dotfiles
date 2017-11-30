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



# Adjust destination paths so the files are separated by OS
HOME_DEST="${REPO_PATH}/home/"
ST_DEST="${REPO_PATH}/sublime/"
VSC_DEST="${REPO_PATH}/code/"
ZSH_DEST="${REPO_PATH}/zsh/"

# Put the destination paths inside an array …
declare -a destinations=(
    "$HOME_DEST"
    "$ST_DEST"
    "$VSC_DEST"
    "$ZSH_DEST"
)

# … and create the necessary destination directories if they don’t exist already
for dest in "${destinations[@]}"; do
    mkdir -p "$dest"
done

# Store kernel name in variable:
unamestr=$(uname -s)

# Detect OS (OS X, Linux or Windows)
printf "Detecting OS: "
if [[ "$unamestr" == "Linux" ]]; then
    OS="Linux"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User"
    VSC_DIR="$HOME/.config/Code/User"
elif [[ "$unamestr" == "MINGW32_NT"* || "$unamestr" == "MINGW64_NT"* ]]; then
    OS="Windows"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User"
    VSC_DIR="$HOME/AppData/Roaming/Code/User"
else
    printf "Could not detect operating system. Aborting."
    exit 2
fi
printf "$OS\n"

echo "Copying files ..."

# Copy files from the home directory (Bash, Git, Ruby, )
cp -u "$HOME/"ubuntu-tips.md "$HOME_DEST"
cp -u "$HOME/".bashrc "$HOME_DEST"
cp -u "$HOME/".aliases "$HOME_DEST"
cp -u "$HOME/".eslintrc.json "$HOME_DEST"
cp -u "$HOME/".gitignore_global "$HOME_DEST"
cp -u "$HOME/".gitconfig "$HOME_DEST"
cp -u "$HOME/".gemrc "$HOME_DEST"
cp -u "$HOME/".npmrc "$HOME_DEST"
cp -u "$HOME/".vimrc "$HOME_DEST"

# ZSH
cp -u "$HOME/".zshrc "$ZSH_DEST"

# Sublime Text
cp -Ru "${ST_DIR}/build-systems/" "$ST_DEST"
cp -Ru "${ST_DIR}/snippets/" "$ST_DEST"
cp -u "${ST_DIR}/"*.sublime-settings "$ST_DEST"
cp -u "${ST_DIR}/"*.sublime-keymap "$ST_DEST"

# Visual Studio Code
cp -Ru "${VSC_DIR}/snippets/" "$VSC_DEST"
cp -u "${VSC_DIR}/"keybindings.json "$VSC_DEST"
cp -u "${VSC_DIR}/"settings.json "$VSC_DEST"

echo "Completed."
