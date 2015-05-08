# Shell script to copy important configuration files on my Ubuntu environment
# to this repository.

# Local location of the repository
REPO_PATH="$HOME/dev/repos/dotfiles/"



# Detect OS (OS X, Linux or Windows)
if [ "$(uname)" == "Darwin" ]; then
    echo "System: OS X"

    OS_PATH="osx/"

    ST_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "System: Linux"

    OS_PATH="linux/"

    ST_DIR="$HOME/.config/sublime-text-3/Packages/User/"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "System: Windows"

    OS_PATH="win/"

    ST_DIR="$HOME/AppData/Roaming/Sublime Text 3/Packages/User/"
    NPM_DIR="$HOME/AppData/Roaming/npm/node_modules/npm/"
fi

# Adjust destination paths so the files are separated by OS
BASH_DEST="${REPO_PATH}${OS_PATH}bash/"
GIT_DEST="${REPO_PATH}${OS_PATH}git/"
NPM_DEST="${REPO_PATH}${OS_PATH}npm/"
RUBY_DEST="${REPO_PATH}${OS_PATH}ruby/"
ST_DEST="${REPO_PATH}${OS_PATH}sublime-text/"

# Create necessary directories if they don't exist
mkdir -p $BASH_DEST
mkdir -p $GIT_DEST
mkdir -p $NPM_DEST
mkdir -p $RUBY_DEST
mkdir -p $ST_DEST



# Bash
cp "$HOME/.bashrc" "$BASH_DEST"
cp "$HOME/.bash_aliases" "$BASH_DEST"

# Git
cp "$HOME/.gitignore_global" "$GIT_DEST"
cp "$HOME/.gitconfig" "$GIT_DEST"

# Node.js/npm
cp "${NPM_DIR}.npmrc" "$NPM_DEST"

# Ruby/RubyGems
cp "$HOME/.gemrc" "$RUBY_DEST"

# Sublime Text (Windows)
cp "${ST_DIR}Preferences.sublime-settings" "$ST_DEST"
cp "${ST_DIR}Default (Linux).sublime-keymap" "$ST_DEST"
cp "${ST_DIR}Default (Windows).sublime-keymap" "$ST_DEST"
cp "${ST_DIR}Package Control.sublime-settings" "$ST_DEST"
cp "${ST_DIR}For Loop (range).sublime-snippet" "$ST_DEST"

echo "Completed."
