# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Jekyll environment
export JEKYLL_ENV=local

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$PATH:/opt/cmake/bin" # Add Cmake to PATH
