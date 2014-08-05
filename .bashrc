. ~/bin/bash_colors.sh

source ~/.userrc

# Add paths that should have been there by default
export PATH=/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'


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

python_module_dir () {
    echo "$(python -c "import os.path as _, ${1}; \
        print _.dirname(_.realpath(${1}.__file__[:-1]))"
        )"
}

source ~/bin/git-completion.bash

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

alias ls='ls -G'
alias ll='ls -lG'
alias grep='grep --color -E'
alias show='find . -name "*.*"'
alias ls='ls -lhG'
alias git-tree='git log --graph --pretty=oneline --abbrev-commit --decorate  --all'
alias timestamp='date +%Y%m%d%H%M%S'

source $workspace/utils/markdown/markdown.sh

if [ "$(uname)" == "Darwin" ]; then
  echo "OK! OSX!"
  source $workspace/utils/dotfiles/.osxbash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "YAY! LINUX!"
  source $workspace/utils/dotfiles/.debbash
else
  echo "FUCK! WINDOWS!"
  source source $workspace/utils/dotfiles/.cygbash
fi

