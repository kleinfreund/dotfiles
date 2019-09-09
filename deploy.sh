#!/bin/bash

# Change directory to the location of this script.
# This way, it can be executed from an arbitrary location.
dotfiles_dir="$(dirname "${BASH_SOURCE}")";
cd $dotfiles_dir;

# Exit as soon as a command fails
set -e;

# Accessing an empty variable will yield an error
set -u;



install_zsh() {
  install_apt_package zsh;
  set_default_shell zsh;

  install_oh_my_zsh;
  install_oh_my_zsh_plugins;
}

# Installs a package with apt with “sudo apt install $1”.
install_apt_package() {
  if [ -x "$(command -v $1)" ]; then
    return 0;
  fi

  if prompt_yes_no "Do you want to install $1?"; then
    sudo apt install $1 -y;
    echo "✅ $1 was successfully installed.";
  else
    exit 0;
  fi
}

# Installs an NPM package with “npm install --global $1”
install_npm_package() {
  if ! [ `npm list -g | grep -c $1` -eq 0 ]; then
    return 0;
  fi

  if prompt_yes_no "Do you want to install $1?"; then
    npm install --global $1;
    echo "✅ $1 was successfully installed.";
  fi
}

# Changes the default shell with “chsh -s $(which $1)”.
set_default_shell() {
  echo "Checking if $1 is the default shell …";
  if [[ -z "${SHELL##*$1*}" ]]; then
    echo "✅ $1 is the default shell already. Continuing.";
    return 0;
  fi

  echo "$1 is not the default shell.";
  if prompt_yes_no "Do you want to make $1 the default shell?"; then
    echo "The script will now ask you for your user account’s password again.";
    chsh -s $(which $1);
    echo "Please log out of your user session for this to take effect and run this script again."
  fi

  exit 0;
}

# Installs Oh My Zsh
install_oh_my_zsh() {
  if [[ ${SHELL#/usr/bin/} == "zsh" ]]; then
    install_apt_package curl;

    echo "Checking if Oh My Zsh is installed …";
    # Assume that Oh My Zsh is installed if its directory exists.
    if [ -d "~/.oh-my-zsh" ]; then
      echo "Oh My Zsh is not installed."

      if prompt_yes_no "Do you want to install Oh My Zsh?"; then
        echo "Installing Oh My Zsh …";
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

        echo "✅ Done. Oh My Zsh was installed.";
      fi
    else
      echo "✅ Oh My Zsh is already installed. Continuing."
    fi
  else
    echo "❌ zsh is not the default shell. Exiting."
    exit 1;
  fi
}


install_oh_my_zsh_plugins() {
  if prompt_yes_no "Do you want to install/update the Z shell plugins?"; then
    echo "Installing Z shell plugins …";

    mkdir -p ~/.oh-my-zsh/custom;

    echo "Installing zsh-syntax-highlighting …";
    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
      rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
    fi

    # https://github.com/zsh-users/zsh-syntax-highlighting/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;

    echo "Installing zsh-autosuggestions …";
    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
      rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
    fi

    # https://github.com/zsh-users/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;

    echo "✅ Installed the Z shell plugins.";
  fi
}

# Creates symbolic links to the user’s home directory for all files in dotfiles’ “home” directory.
symlink_dotfiles() {
  echo "Setting up symbolic links for …";

  # Looping through file system objects in a path also finds hidden files
  shopt -s dotglob

  for absolute_file_path in $PWD/home/*; do
    local file_name="$(basename "$absolute_file_path")"
    # Check if they represent an actual file
    if [ -f ${absolute_file_path} ]; then
      # Create a symbolic link in ~
      # /!\ Overwrites existing files/links
      ln -sfn ${absolute_file_path} ~/${file_name};
      echo "  ~/${file_name} → ${absolute_file_path}";
    fi
  done
  unset absolute_file_path;

  echo "✅ Done setting up symbolic links.";
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

echo "The script will now ask you for your user account’s password.";

sudo apt update;

install_zsh;

symlink_dotfiles;

install_apt_package htop;
install_apt_package tree;
install_apt_package fd-find;
