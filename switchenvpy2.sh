#!/bin/bash
# Automatically switches environments python

if [[ "$PATH" = "$USR_PATH:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH" ]]; then
  export PATH=$USR_PATH:$CYG_PYTHON:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
  echo "You are now using Windows Python"
elif [[ "$PATH" = "$USR_PATH:$CYG_PYTHON:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH" ]]; then
  export PATH=$USR_PATH:$CYG_NODE:$CYG_LOCAL_NPM:$BASE_UNIX_PATH:$CYG_PATH:$CYG_WINPATH
  echo "You are now using Cygwin Python"
else
  echo "I Don't Even"
fi
