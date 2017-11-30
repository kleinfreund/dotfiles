#!/bin/bash

# Exit as soon as a command fails
set -e

# Accessing an empty variable will yield an error
set -u

# Checks if $1 is installed.
# If not, calls the appropriate function to install $1.
install_if_needed() {
  printf "Is $1 installed? "
  # Check whether zsh is installed
  if [ -x "$(command -v $1)" ]; then
    printf $(green "Good\n")
  else
    printf $(red "Nope\n")
    install $1
  fi
}

# Print argument in bold red
red() {
  echo "\e[1;31m$1\e[0m"
}

# Print argument in bold green
green() {
  echo "\e[1;32m$1\e[0m"
}

# Installs the program $1 with `apt install`
install() {
  while true; do
    read -p "Would you like to install $1? [yN] " answer
    case $answer in
      Y|y|Yes|yes )
        sudo apt install $1 -y
        break
        ;;
      * )
        echo "$1 was not installed."
        exit 0
        ;;
    esac
  done
}

# Checks if $1 is the default shell.
# If not, calls the appropriate function to change the default shell to $1.
default_shell_if_needed() {
  printf "Is $1 the default shell? "
  if [ -z "${SHELL##*$1*}" ]; then
    printf $(green "Nice\n")
  else
    printf $(red "Yikes\n")
    set_default_shell $1
  fi
}

# Sets the default shell to $1 with `chsh -s`
set_default_shell() {
  while true; do
    read -p "Should $1 be the default shell? [yN] " answer
    case $answer in
      Y|y|Yes|yes )
        chsh -s $(which zsh)
        break
        ;;
      * )
        echo "Default shell was not changed."
        exit 0
        ;;
    esac
  done
}

# Creates symbolic links to all dotfiles
symlink_dotfiles() {
  # Assuming the dotfiles directory resides in $HOME
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

  echo "Done."
}

install_if_needed zsh

default_shell_if_needed zsh

symlink_dotfiles
