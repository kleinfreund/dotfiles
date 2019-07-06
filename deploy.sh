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
install_package() {
  printf "Is $1 installed? ";
  # Check whether zsh is installed
  if [ -x "$(command -v $1)" ]; then
    printf $(green "Yes\n");
    return 0;
  fi

  printf $(red "No\n");

  if prompt_yes_no "Would you like to install $1?"; then
    sudo apt install $1 -y;
  else
    echo "$1 was not installed.";
    exit 0;
  fi
}

install_npm_package() {
  printf "Is $1 installed? ";
  # Check whether zsh is installed
  if ! [ `npm list -g | grep -c $1` -eq 0 ]; then
    printf $(green "Yes\n");
    return 0;
  fi

  printf $(red "No\n");

  if prompt_yes_no "Would you like to install $1?"; then
    npm install --global $1;
  else
    echo "$1 was not installed.";
  fi
}

# Checks if $1 is the default shell.
# If not, calls the appropriate function to change the default shell to $1.
set_default_shell() {
  printf "Is $1 the default shell? ";
  if [[ -z "${SHELL##*$1*}" ]]; then
    printf $(green "Yes\n");
    return 0;
  fi

  if prompt_yes_no "Do you want to make $1 the default shell?"; then
    echo "The script will now ask you for your user account’s password again.";
    chsh -s $(which $1);
    echo "Please log out of your user session for this to take effect and run this script again."
  else
    echo "Default shell was not changed.";
  fi

  exit 0;
}

install_oh_my_zsh() {
  if [[ ${SHELL#/usr/bin/} == "zsh" ]]; then
    install_package curl;

    if ! [[ -f "~/oh-my-zsh.sh" ]]; then
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

echo "The script will now ask you for your user account’s password.";

sudo apt update;

install_package zsh;
set_default_shell zsh;

install_oh_my_zsh;

symlink_dotfiles;

install_package htop;
install_package tree;
