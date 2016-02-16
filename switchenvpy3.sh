#!/bin/bash
# Automatically switches environments python

if echo "$PATH" | GREP -q "$CYG_PYTHON" ; then
  #echo "$PATH"
  WORK=:$PATH:
  WORK=${WORK/:$CYG_PYTHON:/:}
  WORK=${WORK%:}
  WORK=${WORK#:}
  #echo "$WORK"
  export PATH=$WORK
  echo "You are now using Cygwin Python"
  which python
else
   #echo "$PATH"
   export PATH=$CYG_PYTHON:$PATH
   #echo "$PATH"
   echo "You are now using Windows Python"
   which python
fi
