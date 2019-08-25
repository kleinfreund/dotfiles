#!/bin/bash

# Change directory to the location of this script.
# This way, it can be executed from an arbitrary location.
dotfiles_dir="$(dirname "${BASH_SOURCE}")";
cd $dotfiles_dir;

# Exit as soon as a command fails
set -e;

# Accessing an empty variable will yield an error
set -u;



# Store kernel name in variable:
unamestr=$(uname -s);

# Detect OS (Linux or Windows)
printf "Detecting OS: ";
if [[ "$unamestr" == "Linux" ]]; then
  printf "Linux";

  vscode_dir="$HOME/.config/Code/User";
  albert_dir="$HOME/.config/albert";
elif [[ "$unamestr" == "MINGW32_NT"* || "$unamestr" == "MINGW64_NT"* ]]; then
  printf "Windows";

  vscode_dir="$HOME/AppData/Roaming/Code/User";
else
  echo "Could not detect operating system. Aborting.";
  exit 2;
fi
echo;

echo "Copying Visual Studio Code files ...";
vscode_files="snippets/ keybindings.json settings.json";
mkdir -p "$dotfiles_dir/code";
for file in $vscode_files; do
  [ -f "${vscode_dir}/$file" ] && cp -ur "${vscode_dir}/$file" "$dotfiles_dir/code";
  echo "  ${vscode_dir}/$file";
done

echo "Copying Albert files ...";
albert_files="org.albert.extension.snippets/ org.albert.extension.websearch/ albert.conf";
mkdir -p "$dotfiles_dir/albert";
for file in $albert_files; do
  [ -f "${albert_dir}/$file" ] && cp -ur "${albert_dir}/$file" "$dotfiles_dir/albert";
  echo "  ${albert_dir}/$file";
done

unset dotfiles_dir;

echo "Completed.";
