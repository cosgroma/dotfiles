. ~/bin/bash_colors.sh

# Add paths that should have been there by default
# export PATH=/usr/local/bin:${PATH}
# export PATH="~/bin:$PATH"
# export PATH="$PATH:~/.gem/ruby/1.8/bin"

# PATH="/usr/local/sbin:/usr/local/bin:/Applications/Android Studio.app/sdk/tools:/Applications/Android Studio.app/sdk/platform-tools:${PATH}"
# export PATH


# Add postgres to the path
# export PATH=$PATH:/usr/local/pgsql/bin
# export PATH=$PATH:/Library/PostgreSQL/8.3/bin

# Unbreak broken, non-colored terminal
export TERM='xterm-color'
alias ls='ls -G'
alias ll='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

export CLICOLOR=1
alias grep='grep --color -E'

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# # Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
# grb_git_prompt() {
#     local g="$(__gitdir)"
#     if [ -n "$g" ]; then
#         # local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
#         # if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
#         #     local COLOR=${RED}
#         # elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
#         #     local COLOR=${YELLOW}
#         # else
#         #     local COLOR=${GREEN}
#         # fi
#         # local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
#         # The __git_ps1 function inserts the current git branch where %s is
#         local GIT_PROMPT=`__git_ps1 "(%s)"`
#         echo ${GIT_PROMPT}
#     fi
# }
# PS1="\h:\W\$(grb_git_prompt) \u\$ "
#export PS1='$(__git_ps1) \w\$ '
# export PS1='\h:\W $(git status 2>/dev/null) \u\$'


#export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\][\[$(tput setaf 3)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\W\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"

# function git_cb() {
#   # git status --porcelain&>/dev/null;
#   if  git status --porcelain&>/dev/null; then
#     echo "$(git branch | grep '\*' | cut -d' ' -f2)"
#   fi;
# }
# (\$(git_cb))
export PS1="\[\033[01;32m\]\u\[\033[01;37m\]@\h \[\033[01;33m\]\T \w\[\033[38;5;40m\]\[\e[0m\] \$ "

activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

python_module_dir () {
    echo "$(python -c "import os.path as _, ${1}; \
        print _.dirname(_.realpath(${1}.__file__[:-1]))"
        )"
}

# source ~/bin/git-completion.bash

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

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


if [ "$(uname)" == "Darwin" ]; then
  echo "OK! OSX!"
  source ~/.osxbash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "YAY! LINUX!"
  source ~/.debbash
else
  echo "FUCK! WINDOWS!"
  source ~/.cygbash
fi

alias show='find . -name "*.*"'
alias ls='ls -lhG'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'
alias timestamp='date +%Y%m%d%H%M%S'
