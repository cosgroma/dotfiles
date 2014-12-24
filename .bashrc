#!/bin/bash

## Source user settings
source ~/.userrc

source ~/dfbin/bash_colors.sh
source ~/dfbin/git-completion.bash

source ~/.aliases.sh
source ~/.bash_functions.sh
source ~/.pathdef.sh

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'
export CLICOLOR=1

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

source ~/.ps1_components.sh

case $(uname) in
  Linux)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_PROMPT"
    ;;
  Darwin)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_GIT_STAT$PS1_PROMPT"
    ;;
  *)
    USR_PROMPT="$PS1_USER_HOST$PS1_WORK_DIR$PS1_PROMPT"
    ;;
esac

export PS1="$USR_PROMPT"
export PS2='> '
export PS4='+ '

# source $workspace/utils/markdown/markdown.sh
# source $workspace/apps/git-forest/git-forest.sh
# configuration_set $workspace/apps/git-forest/user_conf.forest
# list_set $workspace/sergeant/seed/sergeant.forest

# if [ "$(uname)" == "Darwin" ]; then
#   source $workspace/utils/dotfiles/.osxbash
# elif [ "$(uname -n)" == "AMDP2X4945" ]; then
#   source $workspace/utils/dotfiles/.mintbash
# elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
#   source $workspace/utils/dotfiles/.debbash
# else
#   echo "FUCK! WINDOWS!"
#   source $workspace/utils/dotfiles/.cygbash
# fi
# PERL_MB_OPT="--install_base \"/Users/cosgroma/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/cosgroma/perl5"; export PERL_MM_OPT;
