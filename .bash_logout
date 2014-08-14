#!/bin/bash

if hash ruby 2>/dev/null; then
ruby ~/dfbin/shellshock.rb; sleep 2; exit
else
source ~/dfbin/see-you.sh; sleep 2; exit
fi
