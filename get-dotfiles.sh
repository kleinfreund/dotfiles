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
ST_DEST="${REPO_PATH}/subl/"
VSC_DEST="${REPO_PATH}/code/"
CMDER_DEST="${REPO_PATH}/cmder/"

# Put the destination paths inside an array …
declare -a destinations=(
    "$HOME_DEST"
    "$ST_DEST"
    "$VSC_DEST"
    "$CMDER_DEST"
)

# … and create the necessary destination directories if they don’t exist already
for dest in "${destinations[@]}"; do
    mkdir -p "$dest"
done

# Usually, `$HOME` has the correct path to the users home directory.
# However on the Linux subsystem for Windows, this is the Linux home
# (`/home/user`) not the Windows home (`/mnt/c/users/user`).
HOME_PATH=$HOME

# Store kernel name in variable:
unamestr=$(uname -s)

# Detect OS (OS X, Linux or Windows)
printf "Detecting OS: "
if [[ "$unamestr" == "Linux" ]]; then
    OS="Linux"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User"
    VSC_DIR="$HOME/.config/Code/User"

    # Weak check if we’re on the Linux subsystem for Windows
    if [[ "$PWD" == "/mnt"* ]]; then
        OS="Linux Subsystem"
        HOME_PATH="/mnt/c/Users/Philipp"
        ST_DIR="$HOME_PATH/AppData/Roaming/Sublime Text 3/Packages/User"
        VSC_DIR="$HOME_PATH/AppData/Roaming/Code/User"
        CMDER_DIR="/mnt/c/cmder"
    fi
elif [[ "$unamestr" == "MINGW32_NT"* || "$unamestr" == "MINGW64_NT"* ]]; then
    OS="Windows"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User"
    VSC_DIR="$HOME/AppData/Roaming/Code/User"
    CMDER_DIR="/c/cmder"
elif [[ "$unamestr" == "Darwin" ]]; then
    OS="macOS"

    ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    VSC_DIR="$HOME/Library/Application Support/Code/User"
else
    printf "Could not detect operating system. Aborting."
    exit 2
fi
printf "$OS\n"

echo "Copying files ..."
# Copy files from the home directory (Bash, Git, Ruby, Hyper, …)
cp -u "$HOME_PATH/".bashrc "$HOME_DEST"
cp -u "$HOME_PATH/".aliases "$HOME_DEST"
cp -u "$HOME_PATH/".gitignore_global "$HOME_DEST"
cp -u "$HOME_PATH/".gitconfig "$HOME_DEST"
cp -u "$HOME_PATH/".gemrc "$HOME_DEST"
cp -u "$HOME_PATH/".npmrc "$HOME_DEST"
cp -u "$HOME_PATH/"ubuntu-tips.md "$HOME_DEST"
cp -u "$HOME_PATH/".zshrc "$HOME_DEST"

# Sublime Text
cp -Ru "${ST_DIR}/build-systems/" "$ST_DEST"
cp -Ru "${ST_DIR}/snippets/" "$ST_DEST"
cp -u "${ST_DIR}/"*.sublime-settings "$ST_DEST"
cp -u "${ST_DIR}/"*.sublime-keymap "$ST_DEST"

# Visual Studio Code
echo "Skipping VSCode"
# cp -Ru "${VSC_DIR}/snippets/" "$VSC_DEST"
# cp -u "${VSC_DIR}/"settings.json "$VSC_DEST"
# cp -u "${VSC_DIR}/"keybindings.json "$VSC_DEST"
# cp -u "${VSC_DIR}/"locale.json "$VSC_DEST"


# OS specific copy operations
if [[ "$OS" == "Linux" ]]; then
    echo "Skipping Hyper"
    # cp -u "$HOME_PATH/".hyper.js "$HOME_DEST"
elif [[ "$OS" == "Linux Subsystem" || "$OS" == "Windows" ]]; then
    cp -u "${CMDER_DIR}/config/"settings "$CMDER_DEST"
    cp -u "${CMDER_DIR}/config/"user-aliases.cmd "$CMDER_DEST"
    cp -u "${CMDER_DIR}/config/"user-profile.cmd "$CMDER_DEST"
    cp -u "${CMDER_DIR}/config/"user-startup.cmd "$CMDER_DEST"
    cp -u "${CMDER_DIR}/vendor/conemu-maximus5/"ConEmu.xml "$CMDER_DEST"
fi

echo "Completed."
