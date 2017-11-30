#!/bin/bash

# Exit as soon as a command fails
set -e

# Accessing an empty variable will yield an error
set -u

# Assumption: The dotfiles directory resides in $HOME
dotfiles_dir="$HOME/dotfiles/home"

# Go to the dotfiles directory.
# This allows the script to be executed from elsewhere
cd $dotfiles_dir

echo "Creating symbolic links for ..."
dotfiles=".aliases .bashrc .zshrc .vimrc .npmrc .gemrc .gitconfig .gitignore_global .eslintrc.json"

# For all entries in $dotfiles
for file in $dotfiles; do
  # Check if they represent an actual file
  if [ -f ${dotfiles_dir}/${file} ]; then
    # Create a symbolic link in $HOME
    # /!\ Overwrites existing files/links
    ln -sfn ${dotfiles_dir}/${file} $HOME/${file}
    echo "  ${file} -> ${dotfiles_dir}/${file}"
  fi
done

echo "Completed."
