#!/bin/bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Source user settings
unset PROMPT_COMMAND

source $HOME/.dfbin/getarch.sh
# source user settings, defines $hush, $user, $name, $email, $userpass64
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
fi

if ! [[ -e $HOME/.useraliases.sh ]]; then touch $HOME/.useraliases.sh; fi

source $HOME/.useraliases.sh

# export TERM='screen-256color'
export TERM='xterm-256color'

export CLICOLOR=1

eval "$(dircolors -b $HOME/.dircolorsrc)"

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

[[ -e $HOME/.dfuser ]] || mkdir $HOME/.dfuser

# souch .dfuser/settings.sh if it exists
[[ -e $HOME/.dfuser/settings.sh ]] && source $HOME/.dfuser/settings.sh || touch $HOME/.dfuser/settings.sh

# if [[ -z $hush ]]; then
#   echo "Sourcing user scripts from $HOME/.dfuser"
# else
#   hush=true
# fi

script_load_cnt=0

for f in $(find $HOME/.dfuser -maxdepth 1 -name "*.sh" | sort | uniq); do
    $hush || echo $f
    fn=$(basename $f)

    [[ $fn =~ ^_ ]] && echo "skipping " $fn || {
        source $f && $hush || echo "sourcing $fn"
        ((script_load_cnt++))
    }

done

$hush || echo "loaded $script_load_cnt scripts"

# Created by `pipx` on 2025-07-17 18:47:36
export PATH="$PATH:$HOME/.local/bin"
