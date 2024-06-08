#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source user settings
unset PROMPT_COMMAND;

source $HOME/.userrc

source $HOME/dfbin/bash_colors.sh
source $HOME/dfbin/git-completion.bash

source $HOME/.aliases.sh
source $HOME/.bash_functions.sh

DEF_PATH=$PATH

if [[ -e $HOME/.userpath.sh ]]; then
  source $HOME/.userpath.sh
else
  PATH=$HOME/dfbin:$PATH
fi;

if ! [[ -e $HOME/.useraliases.sh ]]; then touch $HOME/.useraliases.sh; fi

source $HOME/.useraliases.sh

# export TERM='screen-256color'
export TERM='xterm-256color'

export CLICOLOR=1

eval "`dircolors -b $HOME/.dircolorsrc`"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r;"

source $HOME/.ps1_components.sh

case $(uname) in
  Linux)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_XILINX$PS1_GITF$PS1_WENV$PS1_END"
    export PLATFORM=linux
    ;;
  Darwin)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_PROMPT_RST"
    ;;
  *)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GITF$PS1_END"
    ;;
esac

export PS1="$USR_PROMPT"
export PS2='> '
export PS4='+ '

[[ -e $HOME/.dfuser ]] || mkdir $HOME/.dfuser
for f in `find $HOME/.dfuser -name "*.sh"`; do
  fn=$(basename $f)
  [[ $fn =~ ^_ ]] && echo "skipping " $fn || {
    echo "sourcing $fn"
    source $f;
  };
done;

# for f in `find $HOME/.dfuser/apikeys -name "*.apikey"`; do
  
#   fn=$(basename $f)
#   name=${fn%.*}
#   [[ $fn =~ ^_ ]] && echo "skipping " $fn || {
#     echo "sourcing $fn"
#     source $f;
#   };
# done;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cosgroma/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cosgroma/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cosgroma/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cosgroma/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

