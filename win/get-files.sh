# Shell script to copy important configuration files on my Ubuntu environment
# to this repository.

# Local location of the repository
BASH_DEST=~/dev/repos/dotfiles/win/bash/
GIT_DEST=~/dev/repos/dotfiles/win/git/
ST_DEST=~/dev/repos/dotfiles/win/sublime-text/

# Bash
cp ~/.bashrc "$BASH_DEST"
cp ~/.bash_aliases "$BASH_DEST"

# Git
cp ~/.gitignore_global "$GIT_DEST"
cp ~/.gitconfig "$GIT_DEST"

# Sublime Text (Windows)
cp ~/AppData/Roaming/"Sublime Text 3"/Packages/User/Preferences.sublime-settings "$ST_DEST"
cp ~/AppData/Roaming/"Sublime Text 3"/Packages/User/"Default (Windows).sublime-keymap" "$ST_DEST"
cp ~/AppData/Roaming/"Sublime Text 3"/Packages/User/"Package Control.sublime-settings" "$ST_DEST"
cp ~/AppData/Roaming/"Sublime Text 3"/Packages/User/"For Loop (range).sublime-snippet" "$ST_DEST"
