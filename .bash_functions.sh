
### Get os name via uname ###
_myos="$(uname)"

# # Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

function aalias() { echo "alias $1='$(fc -ln -2 | head -1 | sed "1s/^[[:space:]]*//")'" >> ~/.useraliases.sh; }

function make-list() { make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | sort; }

# function dos2unix() {
#   for f in `find . -name "*" -type  f`; do
#     cp $f $f.orig && tr -d '\015' <$f >$f.conv && mv $f.conv $f;
#   done;
# }

function yo() {
  if type ruby &>/dev/null; then
    ruby ~/dfbin/shellshock.rb;
  else
    source ~/dfbin/see-you.sh;
  fi
}

function ch () {
    cd "$@"
    export HISTFILE="$(pwd)/.bash_history"
}

function test_proxy() {
  if wget -q --spider www.google.com; then
    echo -e $GREEN"PASS"$RESET;
  else
    echo -e $RED"FAIL"$RESET": using proxy "$YELLOW$http_proxy$RESET;
  fi;
}

function rstenv() { export PATH=$DEF_PATH; }

function doc2text() {
  if [ -f $1 ] ; then
    unzip -p $1 word/document.xml | sed -e $'s/<\/w:t>/\\\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g'
  else
    echo "cannot open $1"
  fi
}

rmrb() { for r in `git remote`; do git push $r --delete $1; done; }

function set_xilinx_version() {
  case $_myos in
     Linux) VIVADO_PATH=/opt/Xilinx/Vivado ;;
         *) VIVADO_PATH=/cygdrive/c/Xilinx/Vivado ;;
  esac
  [[ -e $VIVADO_PATH ]] || (echo "ERROR: vivado not installed "; return)
  printf -v str '%s ' `ls $VIVADO_PATH`;
  IFS=' ' declare -a 'versions=($str)';
  vlen=${#versions[@]};
  while true; do
    echo -e "Select Version ($GREEN[*]$RESET current):"
    for (( i=0; i<${vlen}; i++ )); do
      [[ -n $xilinx_version && $xilinx_version == ${versions[$i]} ]] && attr="[*] " || attr="    "
      echo -e $i ':'$GREEN$attr$RESET${versions[$i]}
    done
    read version
    [[ $version -lt $vlen && $version -ge 0 ]] && break;
    echo -e $RED"ERROR"$RESET": bad selection $YELLOW$version$RESET"
  done
  xilinx_version=${versions[$version]}
  echo -e "set version to: $GREEN$xilinx_version$RESET"
}

function xilinx() {
  [[ -z $xilinx_version ]] && set_xilinx_version
  source /opt/Xilinx/SDK/$xilinx_version/settings64.sh
  source /opt/Xilinx/Vivado/$xilinx_version/settings64.sh
}