# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_CUSTOM="$HOME/dotfiles/zsh"

# source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# %n : user name
user_name="%{$fg[green]%}%n%{$reset_color%}"
# %m : host
host_name="%{$fg[green]%}%m%{$reset_color%}"
# %~ : working directory ($HOME is replaced with ~)
working_dir="%{$fg_bold[blue]%}%~%{$reset_color%}"
# BOO!
prompt_char="%{$fg_bold[blue]%}👻%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT="${user_name}@${host_name} in ${working_dir}"
PROMPT+='$(git_prompt_info)'
PROMPT+=$'\n'
PROMPT+="${prompt_char} "



# Aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

up_widget() {
  BUFFER="cd .."
  zle accept-line
}
zle -N up_widget
bindkey "^k" up_widget



# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Jekyll
export JEKYLL_ENV=development

# Hugo
export HUGO_ENV=development

# Webis CVS
export CVS_RSH="/usr/bin/ssh"
export CVSROOT="ranu2619@webisnetwork.uni-weimar.de:/srv/cvsroot"
export CVSEDITOR=$EDITOR

# OpenJDK
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Apache Maven
export PATH="$PATH:/opt/apache-maven/bin"

# Custom NPM packages directory
export PATH="$HOME/.npm-global/bin:$PATH"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"
