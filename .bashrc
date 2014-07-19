. ~/bin/bash_colors.sh

# Add paths that should have been there by default
export PATH=/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/1.8/bin"

# PATH="/usr/local/sbin:/usr/local/bin:/Applications/Android Studio.app/sdk/tools:/Applications/Android Studio.app/sdk/platform-tools:${PATH}"
# export PATH

# Add postgres to the path
export PATH=$PATH:/usr/local/pgsql/bin
export PATH=$PATH:/Library/PostgreSQL/8.3/bin

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'
alias ls='ls -G'
alias ll='ls -lG'
# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
# export GREP_OPTIONS="--color"

#export CLICOLOR=1
alias grep='grep --color -E'

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
grb_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
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

#export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\][\[$(tput setaf 3)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\W\[$(tput setaf 2)\]]\[$(tput setaf 4)\] \$(grb_git_prompt)\\$\[$(tput sgr0)\] "

#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;37m\]@\h \[\033[01;33m\]\T \[\033[01;36m\]\w \$ \[\e[0m\]"


PROMPT_INFO="\[\e[38;5;15m\]\u\[\e[38;5;160m\]@\[\e[38;5;249m\]\h \
\[\e[38;5;160m\][\[\e[00;34m\]\W\[\e[38;5;160m\]] \
\[\e[0m\]\$(grb_git_prompt)\
\[\e[00;33m\]{\$?} \
\[\e[0m\]\$ ";

function get_columns {
  echo -n $(($COLUMNS-9))
}

DIGITS="\[\e[38;5;160m\]"
BORDER="\[\033[1;37m\]"
CLOCK="\[\033[s\033[1;\$(echo -n \$(get_columns))H\]$BORDER[$DIGITS\$(date +%H:%M:%S)$BORDER]\[\033[u\]"

export PS1="$CLOCK$PROMPT_INFO"
export PS2='> '
export PS4='+ '

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

source ~/bin/git-completion.bash

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

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


alias show='find . -name "*.*"'
alias ls='ls -lhG'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'

alias timestamp='date +%Y%m%d%H%M%S'





# # Setup for /bin/ls to support color, the alias is in /etc/bashrc.
# if [ -f "$HOME/.dircolors" ] ; then
#     eval $(dircolors -b $HOME/.dircolors)
# fi

if [ "$(uname)" == "Darwin" ]; then
  echo "OK! OSX!"
  source ~/.osxbash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "YAY! LINUX!"
  source ~/.debbash
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo "FUCK! WINDOWS!"
  source ~/.cygbash
fi
