# Shell script to copy important configuration files on my Ubuntu environment
# to this repository.

# Local location of the repository
BASH_DEST=~/dev/repos/dotfiles/ubuntu/bash/
GIT_DEST=~/dev/repos/dotfiles/ubuntu/git/
ST_DEST=~/dev/repos/dotfiles/ubuntu/sublime-text/

# Bash
cp ~/.bashrc "$BASH_DEST"
cp ~/.bash_aliases "$BASH_DEST"

# Git
cp ~/.gitignore_global "$GIT_DEST"
cp ~/.gitconfig "$GIT_DEST"

# Sublime Text (Ubuntu)
cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings "$ST_DEST"
cp ~/.config/sublime-text-3/Packages/User/"Default (Linux).sublime-keymap" "$ST_DEST"
cp ~/.config/sublime-text-3/Packages/User/"Package Control.sublime-settings" "$ST_DEST"
cp ~/.config/sublime-text-3/Packages/User/"For Loop (range).sublime-snippet" "$ST_DEST"
