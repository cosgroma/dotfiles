#!/bin/bash
################################################################################
## @file    .aliases.sh
## @author  Mathew Cosgrove mathew.cosgrove@ngc.com
## @Date:   2014-12-24 10:32:33
## @brief
## @copyright
## @version
## @Last Modified by:   cosgrma
## @Last Modified time: 2015-01-09 13:11:18
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
alias grep='grep --color -E'
alias show='find . -name "*.*"'

# alias work='cd /cygdrive/e/workspace'
# alias work='cd ~/workspace'
# alias cpmk='cp /cygdrive/e/workspace/utils/Makefile-template/Makefile .'

alias reset='exec /bin/bash -l'
# alias reset='exec bash -l'

## Linux Stuff
alias lsusr='cat /etc/passwd | grep /home |cut -d: -f1'
alias mplayer='mplayer -fs'
alias hexdump='od -txa -w16 -Ax'
alias mount='mount |column -t'

## pass options to free ##
alias meminfo='free -m -l -t'

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
alias c='clear'
alias celar='clear'

# Network Stuff
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

# Git
# case $(uname) in
#    Darwin)
#     alias git='hub'
#     ;;
# esac
alias git-prune='for f in $(git ls-files --deleted); do git rm $f; done;'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'

# Python
alias pip-update='pip freeze --local | grep -v '\''^\-e'\'' | cut -d = -f 1 | xargs pip install -U'
alias pypacks='cd /usr/local/Cellar/python/2.7.8/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/'
alias swpy='. switchpy'

alias unpack='find /media/download/seeding -name "*.r00" -mmin -240 -exec unrar x {} /media/download/videos/ \;'

# Torrent Stuff
alias dca='deluge-console add'
alias dci='deluge-console info'
alias dnldng='deluge-console info | grep -B 2 Downloading'
alias transd='sudo transmission-daemon -g /etc/transmission-daemon'
alias tr-cli='transmission-remote-cli -c cosgroma:Pgatour60@localhost:9091'
alias tr-dam='sudo transmission-daemon -t -u cosgroma -v Pgatour60 -g /etc/transmission-daemon/'
alias w2d='python /home/cosgroma/Dropbox/workspace/eclipse_workspace/what_to_download/src/what_to_download.py'

# Environments
alias xenv='source /opt/Xilinx/14.6/ISE_DS/settings64.sh'
alias xenv='source /apps/xilinx147/14.7/ISE_DS/settings64.sh'
alias matlab='/usr/local/MATLAB/R2013a/bin/matlab'

alias reset='exec /bin/bash -l'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias ftp-amd='lftp -u cosgroma,Pgatour60 192.168.2.58'

# Computers
alias tesla='ssh cosgroma@192.168.2.58'
alias teslax='ssh -X cosgroma@192.168.2.58'

## this one saved by butt so many times ##
alias wget='wget -c'

# TIme Stuff
alias timestamp='date +%Y%m%d%H%M%S'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias make='gmake'
