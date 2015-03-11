# Shell script to copy important configuration files on my Ubuntu environment
# to this repository.

# Location of the repository
DEST=~/dev/dotfiles/

# Bash
cp ~/.bashrc "$DEST"
cp ~/.bash_aliases "$DEST"

# Git
cp ~/.gitignore_global "$DEST"
cp ~/.gitconfig "$DEST"

# Sublime Text
cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings "$DEST"
cp ~/.config/sublime-text-3/Packages/User/"Default (Linux).sublime-keymap" "$DEST"
cp ~/.config/sublime-text-3/Packages/User/"Package Control.sublime-settings" "$DEST"
cp ~/.config/sublime-text-3/Packages/User/"For Loop (range).sublime-snippet" "$DEST"
