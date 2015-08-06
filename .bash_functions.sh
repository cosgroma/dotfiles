
### Get os name via uname ###
_myos="$(uname)"

# # Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
# Easy extract
function extract () {
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

function aalias(){
  echo "alias $1='$(fc -ln -2 | head -1 | sed "1s/^[[:space:]]*//")'" >> ~/.aliases.sh
}


# function which () {
#   case $_myos in
#   Linux)
#     /usr/bin/which $1 | xargs -i ls -l {}
#     ;;
#   Darwin)
#     /usr/bin/which $1 | xargs -I {} ls -l {}
#     ;;
#   *)
#     /usr/bin/which $1 | xargs -i ls -l {}
#     # /cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe $(cygpath -aw $1)
#     ;;
#   esac

# }

function make-list() {
  make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'
}

function yo() {
  if type ruby &>/dev/null; then
    ruby ~/dfbin/shellshock.rb;
  else
    source ~/dfbin/see-you.sh;
  fi
}

function test_proxy(){
  if wget -q --spider www.google.com;then
    echo -e "$(color_good PASS): Proxy in good order";
  else
    echo -e "$(color_problem FAIL): Proxy test failed, perhaps update your password";
  fi;
}

function subl {
  case $_myos in
    Linux)
      /usr/bin/subl $1
      ;;
    Darwin)
      /usr/bin/subl $1
      ;;
    *)
      /cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe $(cygpath -aw $1)
      ;;
  esac

}

# function exit() {
#   if type ruby 2>/dev/null; then
#     ruby ~/dfbin/shellshock.rb; sleep 2; builtin exit
#   else
#     source ~/dfbin/see-you.sh; sleep 2; builtin exit
#   fi
# }

function rstenv() {
    export PATH=$DEF_PATH
}

# function python() {
#   case $(uname) in
#     Darwin|Linux)
#       /usr/local/bin/python ${@}
#       ;;
#     *)
#       declare -a cmd_list
#       local i=0
#       for arg in ${@}; do
#         if [[ -e $arg ]]; then
#           cmd_list[$i]=$(cygpath -aw $arg)
#         else
#           cmd_list[$i]=$arg
#         fi
#         i=$(($i + 1))
#       done;
#       /cygdrive/c/Python27/python.exe ${cmd_list[@]}
#       # for c in ${cmd_list[*]}; do
#       #   echo $c
#       # done;
#       # /cygdrive/c/Python27/python.exe
#       # /cygdrive/c/Python27/python.exe $(cygpath -aw $@)
#       ;;
#   esac
# }