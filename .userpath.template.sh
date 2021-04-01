
USR_PATH=$HOME/.dfbin:$HOME/bin:$HOME/usr/bin:$HOME/opt
BASE_UNIX_PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

function _northrop_proxy() {
  export http_proxy=http://$nuser:$(echo -n $userpass64 | base64 -d | sed 's/;/%3B/g' )@westproxy.northgrum.com:80/
  export https_proxy=http://$nuser:$(echo -n $userpass64 | base64 -d | sed 's/;/%3B/g' )@westproxy.northgrum.com:80/
  export no_proxy=.northgrum.com,.ngc
}

function _osx_exports() {
  # export ANDROID_HOME="/Applications/Android Studio.app/sdk"
  current_python=$(echo $(which python) | cut -d'>' -f2 | cut -d'/' -f5)
  # export PYTHONPATH=/usr/local/lib/$current_python/site-packages:/Users/cosgroma/workspace/libs/python/modules:/Users/cosgroma/workspace/sergeant/guis
}

function _xil_exports() {
  export XILINXD_LICENSE_FILE=28039@rsemd1-btriad1.nges.northgrum.com:28039@rsemd1-btriad2.nges.northgrum.com:28039@rsemd1-btriad3.nges.northgrum.com
  export LM_LICENSE_FILE=28041@rsemd1-btriad1.NGES.northgrum.com:28041@rsemd1-btriad2:28039@rsemd1-btriad1.nges.northgrum.com:28039@rsemd1-btriad2.nges.northgrum.com:28039@rsemd1-btriad3.nges.northgrum.com:2100@rseil1-eng4:2100@rseil1-eng3:2100@rseil1-eng2
  #export XILINXD_LICENSE_FILE=28013@rsemd1-btriad1.northgrum.com:28013@rsemd1-btriad2.northgrum.com:28013@rsemd1-btriad3.northgrum.com
}

function _wind_exports() {
  export LM_LICENSE_FILE=28041@rsemd1-btriad1.NGES.northgrum.com,28041@rsemd1-btriad2
}


case $(uname) in
  Darwin)
    OSX_PATH=/opt/local//usr/local/pgsql/bin:/Library/PostgreSQL/8.3/bin:/opt/X11/bin:/usr/texbin
    OSX_PORT_PATH=/opt/local/libexec/gnubin:/opt/local/bin
    export PATH=$OSX_PORT_PATH:$USR_PATH:$BASE_UNIX_PATH:$OSX_PATH
    _osx_exports
    ;;
  Linux)
    case $(uname -n) in
      lcae*.northgrum.com )
        CLUSTER_PATH=/apps/mentor/modelsim/10.1a/modeltech/bin:/apps/mentor/modelsim/10.1a/modeltech/gcc:/apps/xilinx/ISE_DS/common/bin/lin64:/apps/xilinx/ISE_DS/ISE/sysgen/bin:/apps/xilinx/ISE_DS/PlanAhead/bin:/apps/xilinx/ISE_DS/ISE/bin/lin64:/apps/xilinx/ISE_DS/ISE/sysgen/util:/apps/xilinx/ISE_DS/EDK/bin/lin64:/apps/xilinx/ISE_DS/EDK/gnu/microblaze/lin64/bin:/apps/xilinx/ISE_DS/EDK/gnu/powerpc-eabi/lin64/bin:/apps/synplicity/fpga_e201103sp2/bin:/apps/identify/linux/identify_e201103sp1-1/bin:/apps/libero/Libero/bin:/apps/cadence/tools.lnx86/pcb/bin:/apps/cadence/tools.lnx86/specctra/bin:/apps/cadence/tools.lnx86/bin:/apps/cadence/tools.lnx86/fet/bin:/usr/local:/usr/lib:/usr/local/bin:.:/apps/EDA:/usr/local:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/apps/altera/quartus/bin:/apps/altera/nios2eds/bin:/apps/altera/nios2eds/sdk2/bin
        export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
        if ! [[ $(whoami) = "cosgrma" ]]; then
          USR_PATH=/home/cosgrma/bin:$USR_PATH
          export LD_LIBRARY_PATH=/home/cosgrma/lib64:/home/cosgrma/lib:$LD_LIBRARY_PATH
          export PKG_CONFIG_PATH=/home/cosgrma/lib64/pkgconfig:/home/cosgrma/lib/pkgconfig
          export NVM_DIR="/home/cosgrma/.nvm"
        else
          export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:$LD_LIBRARY_PATH
          export PKG_CONFIG_PATH=$HOME/lib64/pkgconfig:$HOME/lib/pkgconfig
          export NVM_DIR="$HOME/.nvm"
        fi
        alias wenv='eval `/home/cosgrma/opt/windriver/wrenv.sh -p vxworks-6.9 -o print_env -f sh`'
        export PATH=$USR_PATH:$BASE_UNIX_PATH:$CLUSTER_PATH
        export XILINXD_LICENSE_FILE=2100@ecae1:28039@rsemd1-btriad1.nges.northgrum.com,28039@rsemd1-btriad2.nges.northgrum.com,28039@rsemd1-btriad3.nges.northgrum.com:2100@rseil1-eng4,2100@rseil1-eng3,2100@rseil1-eng2
        export LM_LICENSE_FILE=28041@rsemd1-btriad1.NGES.northgrum.com,28041@rsemd1-btriad2
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        # _xil_exports
        _northrop_proxy
        ;;
      magellan.northgrum.com )
        export PATH=$PATH:$USR_PATH:$BASE_UNIX_PATH:/opt/MATLAB/R2016a/bin
        export MLM_LICENSE_FILE=28004@Matlab-BWI-1.ES.northgrum.com:28004@Matlab-BWI-2.ES.northgrum.com:28004@Matlab-BWI-3.ES.northgrum.com
        export XILINXD_LICENSE_FILE=2100@ecae1:28039@rsemd1-btriad1.nges.northgrum.com,28039@rsemd1-btriad2.nges.northgrum.com,28039@rsemd1-btriad3.nges.northgrum.com:2100@rseil1-eng4,2100@rseil1-eng3,2100@rseil1-eng2
        export LM_LICENSE_FILE=28041@rsemd1-btriad1.NGES.northgrum.com,28041@rsemd1-btriad2
        export WRSD_LICENSE_FILE=28041@RSMVAG-EEDSLIC1
        _northrop_proxy
        # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
        # export PATH="$PATH:$HOME/.rvm/bin"
        export PATH="$HOME/.rvm/bin:$PATH"
	      export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        ;;
      faraday|magellan )
        export PATH=$USR_PATH:$BASE_UNIX_PATH
        export PYTHONPATH=/home/cosgroma/workspace/libs/python/modules:/usr/local/lib/python2.7/dist-packages:$PYTHONPATH
        _northrop_proxy
        _xil_exports
        ;;
      * )
        MATLAB_PATH=/usr/local/MATLAB/R2013a/bin
        export PYTHONPATH=/home/cosgroma/workspace/libs/python/modules:$PYTHONPATH
        export PATH=$USR_PATH:$BASE_UNIX_PATH:$MATLAB_PATH
        ;;
    esac
    ;;
  *)
    CYG_PATH=/usr/lib/lapack
    CYG_WINPATH=/cygdrive/c/Windows:/cygdrive/c/Windows/system32:/cygdrive/c/Windows/System32/Wbem
    CYG_PYTHON=/cygdrive/c/Python27:/cygdrive/c/Python27/Lib/site-packages:/cygdrive/c/Python27/Scripts:/cygdrive/c/Program\ Files\ \(x86\)/Graphviz2.38/bin
    CYG_NODE=/cygdrive/c/Program\ Files/nodejs
    CYG_LOCAL_NPM=/cygdrive/c/Users/cosgrma/AppData/Roaming/npm
    CYG_RUBY=/cygdrive/c/Ruby22-x64/bin
    export PATH=$USR_PATH:$CYG_PYTHON:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    _northrop_proxy
    ;;
esac
