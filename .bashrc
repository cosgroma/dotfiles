. ~/bin/bash_colors.sh

export PATH=/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/1.8/bin"

source ~/.userrc

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

source ~/.ps1rc

export PS1="$USR_PROMPT"
export PS2='> '
export PS4='+ '

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'

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
  source $workspace/utils/dotfiles/.cygbash
fi


