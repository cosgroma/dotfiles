#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source user settings
unset PROMPT_COMMAND;

source $HOME/.dfbin/getarch.sh
source $HOME/.userrc

source $HOME/.dfbin/bash_colors.sh
source $HOME/.dfbin/git-completion.bash

source $HOME/.aliases.sh
source $HOME/.bash_functions.sh

DEF_PATH=$PATH

if [[ -e $HOME/.userpath.sh ]]; then
  source $HOME/.userpath.sh
else
  PATH=$HOME/.dfbin:$PATH
fi;

if ! [[ -e $HOME/.useraliases.sh ]]; then touch $HOME/.useraliases.sh; fi

source $HOME/.useraliases.sh

# export TERM='screen-256color'
export TERM='xterm-256color'

export CLICOLOR=1

eval "`dircolors -b $HOME/.dircolorsrc`"

shopt -s checkwinsize

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=50000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r;"
# export HISTIGNORE="history:ls:pwd:"
# export HISTFILE=/home/$USER/.bash_history
source $HOME/.ps1_components.sh



case $(uname) in
  Linux)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_XILINX$PS1_GITF$PS1_WENV$PS1_END"
    export PLATFORM=linux
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
    source $f && echo "sourcing $fn";
  };
done;

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export no_proxy=$no_proxy,192.168.2.0/16
