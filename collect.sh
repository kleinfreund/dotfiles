#!/bin/bash

vscode_files=( snippets/ keybindings.json settings.json );
albert_files=( org.albert.extension.snippets/ org.albert.extension.websearch/ albert.conf );

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

# Checks whether a argument 1 is either a regular file or a directory.
# Argument 1: The path to check.
is_file_or_directory() {
  [[ -f $1 || -d $1 ]]
}

# Copies a list of files.
# Argument 1: Source path directory to copy files from.
# Argument 2: Target path directory to copy files to.
# Argument 3–n: List of file or directory names to copy from source directory.
copy_files() {
  local source_dir_path="$1"; # Store argument 1 in variable
  local target_dir_path="$2"; # Store argument 1 in variable
  shift # Shift arguments to delete argument 1
  shift # Shift arguments to delete argument 2
  local file_names=("$@"); # Create list from all the remaining arguments

  mkdir -p $target_dir_path;
  for file in "${file_names[@]}"; do
    local source_file_path="$source_dir_path/$file";

    if is_file_or_directory "$source_file_path"; then
      cp -ur "$source_file_path" $target_dir_path;
      echo " • $source_file_path ✔";
    else
      echo " • $source_file_path ❌";
    fi
  done
}

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

echo "Copying VS Code files …";
copy_files ${vscode_dir} "$dotfiles_dir/code" "${vscode_files[@]}"

echo "Copying Albert files …";
copy_files ${albert_dir} "$dotfiles_dir/albert" "${albert_files[@]}"

unset dotfiles_dir;

echo "Completed.";
