# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  # https://github.com/zsh-users/zsh-syntax-highlighting/
  zsh-syntax-highlighting

  # https://github.com/zsh-users/zsh-autosuggestions
  zsh-autosuggestions

  # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git
  git
)

# Load completion files for git
# Work around for branch completion not working for “git switch”
# Issue: https://github.com/robbyrussell/oh-my-zsh/issues/8105
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh



# User configuration

# https://github.com/robbyrussell/oh-my-zsh/issues/31
unsetopt nomatch



# Custom prompt

# %n : user name
user_name="%{$fg[green]%}%n%{$reset_color%}"
# %m : host
host_name="%{$fg[green]%}%m%{$reset_color%}"
# %~ : working directory ($HOME is replaced with ~)
working_dir="%{$fg_bold[magenta]%}%~%{$reset_color%}"
# BOO!
prompt_char="%{$fg_bold[magenta]%}👻%{$reset_color%}"
new_line=$'\n'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT="${user_name}@${host_name} in ${working_dir}"
PROMPT+='$(git_prompt_info)'
PROMPT+="${new_line}${prompt_char} "



# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi



# Aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi



# Ctrl+K to navigate up one level (i.e. cd ..)
up_widget() {
  BUFFER="cd .. && ll"
  zle accept-line
}
zle -N up_widget
bindkey "^k" up_widget



# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Static Site Generators
export ELEVENTY_ENV=development

# Custom NPM packages directory. See:
# https://docs.npmjs.com/getting-started/fixing-npm-permissions
export PATH="$HOME/.npm-global/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
