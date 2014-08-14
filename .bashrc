#!/bin/bash

export PATH=/usr/local/bin:${PATH}
export PATH="$HOME/dfbin:$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/1.8/bin"

source ~/dfbin/bash_colors.sh
source ~/.userrc
source ~/dfbin/git-completion.bash
source ~/.ps1rc

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# # Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

function make_c_project() {
  mkdir $1; cd $1;
  mkdir build;
  mkdir doc;
  mkdir include;
  mkdir src;
  mkdir test;
  cp $workspace/sergeant/utils/makefile/* build/;
  sed -i 's/PROG_NAME/$1/g' build/config.mk
}

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'

alias ls='ls -G'
alias ll='ls -lG'
alias grep='grep --color -E'
alias show='find . -name "*.*"'
alias ls='ls -lhG'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'
alias timestamp='date +%Y%m%d%H%M%S'

# function exit() {
#   if hash ruby 2>/dev/null; then
#     ruby ~/dfbin/shellshock.rb; sleep 2; exit
#   else
#     source ~/dfbin/see-you.sh; sleep 2; exit
#   fi
# }

function make-list() {
  make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'
}

source $workspace/utils/markdown/markdown.sh

source $workspace/apps/git-forest/git-forest.sh
configuration_set $workspace/config/user_conf.forest
list_set $workspace/config/sergeant.forest

if [ "$(uname)" == "Darwin" ]; then
  source $workspace/utils/dotfiles/.osxbash
elif [ $(uname -n) == "AMDP2X4945"]; then
  source $workspace/utils/dotfiles/.mintbash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  source $workspace/utils/dotfiles/.debbash
else
  echo "FUCK! WINDOWS!"
  source $workspace/utils/dotfiles/.cygbash
fi

export PS1="$USR_PROMPT"
export PS2='> '
export PS4='+ '




