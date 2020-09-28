#!/bin/bash
ps_out=`ps | grep $1 | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$1")
if [[ "$result" != "" ]];then
    echo "true"
else
    echo "false"
fi
