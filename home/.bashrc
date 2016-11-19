# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Jekyll environment
export JEKYLL_ENV="local"

# CVS environment
# export CVS_RSH='/usr/bin/ssh'
# export CVSROOT='ranu2619@webisnetwork.uni-weimar.de:/srv/cvsroot'
export CVSEDITOR=subl

# Add RVM to PATH for scripting
if [ -d "$HOME/.rvm/bin" ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# Add Cmake to PATH
if [ -d "/opt/cmake/bin" ]; then
    export PATH="$PATH:/opt/cmake/bin"
fi
