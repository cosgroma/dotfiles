#!/bin/bash
# User enters the version of python that they want to switch to. It should switch pip as well.
version=$1
if [[ $1 = '' ]]; then
  echo "YOU DON'T EVEN PYTHON"
  exit
elif [[ $1 = "wpython" || $1 = "WPython" || $1 = "WPYTHON" ]]; then
  export PATH=$USR_PATH:$CYG_PYTHON:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
  echo "You are now using Windows Python"
elif [[ $1 = "cwpython" || $1 = "CWPython" || $1 = "CWPYTHON" ]]; then
  export PATH=$USR_PATH:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
  echo "You are now using Cygwin Python"
else
  echo "I Don't Even"
fi
