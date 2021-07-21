
USR_PATH=$HOME/.dfbin
BASE_UNIX_PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

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
    ;;
  magellan.northgrum.com )
    export PATH=$USR_PATH:$PATH
    export MLM_LICENSE_FILE=28004@Matlab-BWI-1.ES.northgrum.com:28004@Matlab-BWI-2.ES.northgrum.com:28004@Matlab-BWI-3.ES.northgrum.com
    export XILINXD_LICENSE_FILE=2100@ecae1:28039@rsemd1-btriad1.nges.northgrum.com,28039@rsemd1-btriad2.nges.northgrum.com,28039@rsemd1-btriad3.nges.northgrum.com:2100@rseil1-eng4,2100@rseil1-eng3,2100@rseil1-eng2
    export LM_LICENSE_FILE=28041@rsemd1-btriad1.NGES.northgrum.com,28041@rsemd1-btriad2
    export WRSD_LICENSE_FILE=28041@RSMVAG-EEDSLIC1
    ;;
  * )
    ;;
esac
