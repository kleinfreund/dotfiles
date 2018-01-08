#!/bin/bash

# Change directory to the location of this script.
# This way, it can be executed from an arbitrary location.
dotfiles_dir="$(dirname "${BASH_SOURCE}")";
cd $dotfiles_dir;

# Exit as soon as a command fails
set -e;

# Accessing an empty variable will yield an error
set -u;

# Checks if $1 is installed.
# If not, calls the appropriate function to install $1.
install_if_needed() {
  printf "Is $1 installed? ";
  # Check whether zsh is installed
  if [ -x "$(command -v $1)" ]; then
    printf $(green "Yes\n");
  else
    printf $(red "No\n");
    install $1;
  fi
}

# Installs the program $1 with `apt install`
install() {
  if prompt_yes_no "Would you like to install $1?"; then
    sudo apt install $1 -y;
  else
    echo "$1 was not installed.";
    exit 0;
  fi
}

# Checks if $1 is the default shell.
# If not, calls the appropriate function to change the default shell to $1.
default_shell_if_needed() {
  printf "Is $1 the default shell? ";
  if [[ -z "${SHELL##*$1*}" ]]; then
    printf $(green "Yes\n");
  else
    printf $(red "No\n");
    set_default_shell $1;
  fi
}

# Sets the default shell to $1 with `chsh -s`
set_default_shell() {
  if prompt_yes_no "Should $1 be the default shell?"; then
    chsh -s $(which $1);
  else
    echo "Default shell was not changed.";
    exit 0;
  fi
}

install_oh_my_zsh() {
  if [[ ${SHELL#/usr/bin/} == "zsh" ]]; then
    install_if_needed curl;

    if ! [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
      if prompt_yes_no "Would you like to install Oh My Zsh?"; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
      else
        echo "Oh My Zsh was not installed.";
      fi
    fi
  fi
}

# Creates symbolic links to all dotfiles
symlink_dotfiles() {
  echo "Creating symbolic links for ...";
  local dotfiles=".aliases .bashrc .zshrc .vimrc .gemrc .gitconfig .gitignore_global .eslintrc.json";

  # For all entries in $dotfiles
  for file in $dotfiles; do
    local file_path=$PWD/home/${file}
    # Check if they represent an actual file
    if [ -f ${file_path} ]; then
      # Create a symbolic link in ~
      # /!\ Overwrites existing files/links
      ln -sfn ${file_path} ~/${file};
      echo "  ~/${file} -> ${file_path}";
    fi
  done

  echo "Done.";
}

# Asks for user confirmation. Returns a zero exit code to signal that the function
# was executed successfully; otherwise a non-zero exit code is returned.
prompt_yes_no() {
  while true; do
    read -p "$1 [yN] " answer;
    case $answer in
      [Yy]|[Yy]es )
        return 0;
        ;;
      * )
        return 1;
        ;;
    esac
  done
}

# Print argument in bold red
red() {
  echo "\e[1;31m$1\e[0m";
}

# Print argument in bold green
green() {
  echo "\e[1;32m$1\e[0m";
}

install_if_needed zsh;
default_shell_if_needed zsh;

install_oh_my_zsh;

symlink_dotfiles;
