#!/bin/bash

## Source user settings

source ~/.userrc

source ~/dfbin/bash_colors.sh
source ~/dfbin/git-completion.bash

source ~/.aliases.sh
source ~/.bash_functions.sh
source ~/.pathdef.sh

# Unbreak broken, non-colored terminal
#export TERM='xterm-256color'
export TERM='screen-256color'

export CLICOLOR=1

eval "`dircolors -b ~/.dircolorsrc`"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r;"

source ~/.ps1_components.sh

workspace=$HOME/workspace
if [[ -e $workspace/apps/git-forest/git-forest.sh ]]; then
  source $workspace/apps/git-forest/git-forest.sh
  configuration_set $workspace/config/user_conf.forest
  list_set $workspace/seed/sergeant.forest
fi

case $(uname) in
  Linux)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_PROMPT_RST"
    ;;
  Darwin)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_PROMPT_RST"
    ;;
  *)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_PROMPT_RST"
    ;;
esac

export PS1="$USR_PROMPT"
export PS2='> '
export PS4='+ '

