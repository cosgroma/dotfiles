#!/bin/bash
################################################################################
## @file    .aliases.sh - {{project_name}}
## @author  Mathew Cosgrove mathew.cosgrove@ngc.com
## @Date:   2014-12-24 10:32:33
## @brief
## @copyright
## @version
## @Last Modified by:   Mathew Cosgrove
## @Last Modified time: 2018-10-20 11:25:13
#
## @details
## @par URL
##  @n
#
## @par Purpose
#
##
## @note
##
#
## @par Usage
##
################################################################################

alias ls='ls --color=auto'
alias ll='ls -lhG'
alias la='ls -la'
alias lt='ls -lat'
alias ltr='ls -ltr'

alias grep='grep --color -E'
alias show='find . -name "*"'
alias reset='exec /bin/bash -l'

## Linux Stuff
alias lsusr='cat /etc/passwd | grep /home |cut -d: -f1'
alias hd='od -txa -w16 -Ax'
alias mount='mount | column -t'

## pass options to free ##
alias meminfo='free -m -l -t'
alias df='df -H'
alias du='du -ch'

## find out if remote server is alive or not ##


## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# handy short cuts #
alias h='history'
alias j='jobs -l'
alias clear='printf "\e[H\e[2J"'
alias c='clear'
alias celar='clear'

# Network Stuff
# Stop after sending count ECHO_REQUEST packets #

alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

alias git-prune='for f in $(git ls-files --deleted); do git rm $f; done;'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'

## this one saved by butt so many times ##
alias wget='wget -c --no-check-certificate'

# TIme Stuff
alias timestamp='date +%Y%m%d%H%M%S'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

alias srs='du -h -d 1 | sort -h'
alias gdump='gcc -E -dM - < /dev/null'
alias gcc-specs='echo | gcc -v -x c -E -'
