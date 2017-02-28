#!/bin/bash

# Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

# export PS1="\[\033[01;32m\]\u\[\033[01;37m\]@\h \[\033[01;33m\]\T \w\[\033[38;5;40m\]\[\e[0m\] \$ "
function grb_git_prompt() {
    # local g="$(__gitdir)"
    if [ -e ".git" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
        echo ${GIT_PROMPT}
    fi
}

function get_columns {
  echo -n $(($COLUMNS-9))
}

DIGITS="\[\e[38;5;160m\]"
BORDER="\[\033[1;37m\]"
# CLOCK="\[\033[s\033[1;\$(echo -n \$(get_columns))\]$BORDER[$DIGITS\$(date +%H:%M:%S)$BORDER]\[\033[u\]"
CLOCK="\033\ $(date +%H:%M:%S)"

# PS1_USER_HOST="\[\e[38;5;15m\]\u\[\e[38;5;160m\]@\[\e[38;5;249m\]\h"
# PS1_WORK_DIR="\[\e[38;5;160m\][\[\e[00;34m\]\W\[\e[38;5;160m\]]"
# PS1_GIT_STAT="\[\e[0m\]\$(grb_git_prompt)"
# PS1_RET_STAT="\[\e[00;33m\]{\$?}"
# PS1_PROMPT_RST="\[\e[0m\]\$ "

get_time(){ printf "\033\e[38;5;118m$(date +%H:%M:%S) "; };
time_on=false
show_time() {
    [[ $time_on == true ]] && export PS1=$PREV_PS1 && time_on=false && return
    time_on=true
    PREV_PS1=$PS1
    export PS1=\$\(get_time\)$PS1
}

PS1_USER_HOST="\[\e[38;5;15m\]\u\[\e[38;5;160m\]@\[\e[38;5;249m\]\h"
PS1_WORK_DIR="\[\e[38;5;160m\][\[\e[00;34m\]\W\[\e[38;5;160m\]]"
PS1_GIT_STAT="\[\e[0m\]\$(grb_git_prompt)"
PS1_RET_STAT="\[\e[00;33m\]{\$?}"
PS1_PROMPT_RST="\[\e[0m\]\$ "
PS1_END="\e[0m\$ "

if [[ `whoami` == "root" ]]; then
    PS1_USER_HOST="\[\e[38;5;196m\]\u\[\e[38;5;15m\]@\[\e[38;5;15m\]\h"
    PS1_PROMPT_RST="\[\e[38;5;9m\]# "
fi

function get_xilinx_env() {
    if ! [ -z $XILINX_VIVADO ]; then
        printf "\e[38;5;150m(xlnx)\e[0m"
    fi
}

PS1_XILINX="\$(get_xilinx_env)"

function get_gitf_env() {
    if ! [ -z $GITF_VERSION ]; then
        printf "\e[38;5;150m(gitf-$remote_name)\e[0m"
    fi
}

PS1_GITF="\$(get_gitf_env)"


