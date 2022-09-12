#!/bin/bash

# Change directory to the location of this script.
# This way, it can be executed from an arbitrary location.
dotfiles_dir="$(dirname "${BASH_SOURCE}")";
cd $dotfiles_dir;

# Exit as soon as a command fails
set -e;

# Accessing an empty variable will yield an error
set -u;



# Checks whether a argument 1 is either a regular file or a directory.
#
# Argument 1: The path to check.
is_file_or_directory() {
  [[ -f $1 || -d $1 ]]
}

# Copies a list of files.
#
# Argument 1: Target path directory to copy files to.
# Argument 2–n: List of file or directory paths to copy from source directory.
copy_files() {
  local target_dir_path="$1";

  # Shifts arguments to delete argument 1 so that the next command can grab all remaining ones.
  shift

  local source_file_paths=("$@");

  mkdir -p $target_dir_path;
  for source_file_path in "${source_file_paths[@]}"; do
    if is_file_or_directory "$source_file_path"; then
      cp -ur "$source_file_path" $target_dir_path;
      echo " • $source_file_path ✔";
    else
      echo " • $source_file_path ❌";
    fi
  done
}

# Detects the operating system (Linux, Windows, or macOS).
detect_os() {
  case "$(uname -s)" in
    Darwin)
      os="macos";
      ;;

    Linux)
      os="linux";
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      os="windows";
      ;;

    *)
      os="unknown";
      ;;
  esac
}

detect_os;

printf "OS: ";
if [[ $os == "linux" ]]; then
  printf "Linux";

  vscode_dir="$HOME/.config/Code/User";
  vscode_files=(
    "${vscode_dir}/snippets/"
    "${vscode_dir}/keybindings.json"
    "${vscode_dir}/settings.json"
  );

  albert_dir="$HOME/.config/albert";
  albert_files=(
    "${albert_dir}/org.albert.extension.snippets/"
    "${albert_dir}/org.albert.extension.websearch/"
    "${albert_dir}/albert.conf"
  );

  flameshot_dir="$HOME/.config/flameshot";
  flameshot_files=(
    "${flameshot_dir}/flameshot.ini"
  );

  htop_dir="$HOME/.config/htop";
  htop_files=(
    "${htop_dir}/htoprc"
  );
elif [[ $os == "windows" ]]; then
  printf "Windows";

  vscode_dir="$HOME/AppData/Roaming/Code/User";
  vscode_files=(
    "${vscode_dir}/snippets/"
    "${vscode_dir}/keybindings.json"
    "${vscode_dir}/settings.json"
  );
elif [[ $os == "macos" ]]; then
  printf "macOS";
else
  echo "Could not detect operating system. Aborting.";
  exit 2;
fi
echo;

if [ ! -z ${vscode_dir+x} ]; then
  echo;
  echo "Copying VS Code files …";
  copy_files "$dotfiles_dir/code" "${vscode_files[@]}"
else
  echo "Not copying VS Code files because the directory isn’t set-up.";
fi

if [ ! -z ${albert_dir+x} ]; then
  echo;
  echo "Copying Albert files …";
  copy_files "$dotfiles_dir/albert" "${albert_files[@]}"
else
  echo "Not copying Albert files because the directory isn’t set-up.";
fi

if [ ! -z ${flameshot_dir+x} ]; then
  echo;
  echo "Copying Flameshot files …";
  copy_files "$dotfiles_dir/flameshot" "${flameshot_files[@]}"
else
  echo "Not copying Flameshot files because the directory isn’t set-up.";
fi

if [ ! -z ${htop_dir+x} ]; then
  echo;
  echo "Copying htop files …";
  copy_files "$dotfiles_dir/htop" "${htop_files[@]}"
else
  echo "Not copying htop files because the directory isn’t set-up.";
fi

unset dotfiles_dir;

echo;
echo "Completed.";
