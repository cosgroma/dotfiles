
function _northrop_proxy() {
  export http_proxy=http://$user:$(echo -n $userpass64 | base64 -d)@centralproxy.northgrum.com:80/
  export https_proxy=http://$user:$(echo -n $userpass64 | base64 -d)@westproxy.northgrum.com:80/
}

function _osx_exports() {
  export ANDROID_HOME="/Applications/Android Studio.app/sdk"
  current_python=$(echo $(which python) | cut -d'>' -f2 | cut -d'/' -f5)
  export PYTHONPATH=/usr/local/lib/$current_python/site-packages:/Users/cosgroma/workspace/libs/python/modules:/Users/cosgroma/workspace/sergeant/guis
}

DEF_PATH=$PATH

USR_PATH=$HOME/dfbin:$HOME/bin:$HOME/usr/bin
BASE_UNIX_PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

CYG_PATH=/usr/lib/lapack
CYG_WINPATH=/cygdrive/c/Windows:/cygdrive/c/Windows/system32:/cygdrive/c/Windows/System32/Wbem
CYG_PYTHON=/cygdrive/c/Python27:/cygdrive/c/Python27/Lib/site-packages:/cygdrive/c/Python27/Scripts

OSX_PATH=/usr/local/pgsql/bin:/Library/PostgreSQL/8.3/bin:/opt/X11/bin:/usr/texbin

CLUSTER_PATH=/apps/mentor/modelsim/10.1a/modeltech/bin:/apps/mentor/modelsim/10.1a/modeltech/gcc:/apps/xilinx/ISE_DS/common/bin/lin64:/apps/xilinx/ISE_DS/ISE/sysgen/bin:/apps/xilinx/ISE_DS/PlanAhead/bin:/apps/xilinx/ISE_DS/ISE/bin/lin64:/apps/xilinx/ISE_DS/ISE/sysgen/util:/apps/xilinx/ISE_DS/EDK/bin/lin64:/apps/xilinx/ISE_DS/EDK/gnu/microblaze/lin64/bin:/apps/xilinx/ISE_DS/EDK/gnu/powerpc-eabi/lin64/bin:/apps/synplicity/fpga_e201103sp2/bin:/apps/identify/linux/identify_e201103sp1-1/bin:/apps/libero/Libero/bin:/apps/cadence/tools.lnx86/pcb/bin:/apps/cadence/tools.lnx86/specctra/bin:/apps/cadence/tools.lnx86/bin:/apps/cadence/tools.lnx86/fet/bin:/usr/local:/usr/lib:/usr/local/bin:.:/apps/EDA:/usr/local:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/apps/altera/quartus/bin:/apps/altera/nios2eds/bin:/apps/altera/nios2eds/sdk2/bin

export LD_LIBRARY_PATH=/usr/local/lib

case $(uname) in
  Darwin)
    export PATH=$USR_PATH:$BASE_UNIX_PATH:$OSX_PATH
    _osx_exports
    ;;
  Linux)
    case $(uname -n) in
      lcae1.northgrum.com )
        export PATH=$USR_PATH:$BASE_UNIX_PATH:$CLUSTER_PATH
        export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:$LD_LIBRARY_PATH
        _northrop_proxy
        ;;
      * )
        export PATH=$USR_PATH:$BASE_UNIX_PATH
        ;;
    esac
    ;;
  *)
    export PATH=$USR_PATH:$CYG_PYTHON:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
    _northrop_proxy
    ;;
esac