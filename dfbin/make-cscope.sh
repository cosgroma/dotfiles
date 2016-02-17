#!/bin/bash

if [[ $# == 0 ]]; then
    PDIR=`pwd`
else
    PDIR=$1
fi;

! [ -d "$PDIR" ] && echo "PDIR is not a directory" && exit
csf=$PDIR/cscope.files
t_csf=$PDIR/temp.cscope.files
[ -e "$csf" ] && echo "cleaning previous scope files" && rm $csf

find $PDIR -name "*.[chxsS]" -print > $t_csf

while read line; do
    echo $(cygpath -aw $line) >> $csf;
done < $t_csf

pushd .
cd $PDIR
cscope -b
popd