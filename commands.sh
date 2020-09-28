#!/bin/sh
IP=$(cat ip)
KEY=$(cat api_key)
URL="http://${IP}/api/sms"
case "$1" in
2)
    echo 'REBOOT'
    reboot
;;
3)
    echo 'SEND USSD'
    /bin/sh /root/hilink.sh send_ussd "*$2#" > /dev/null
    sleep 10
    echo $(/bin/sh /root/hilink.sh get_ussd $2 | while read line; do echo -n "${line}###"; done) > last_ussd.xml
    CONTENT=$(awk -F "[><]" '{print $7}' last_ussd.xml)
    SREQ=$(curl -s -X POST "${URL}" -H "Content-Type: application/json" -d "{\"key\":\"${KEY}\",\"phone\":\"USSD:$2\",\"msg\":\"$CONTENT\"}" -s >/dev/null)
;;
4)
    echo 'START TINC'
    /usr/sbin/tincd -n rcp 
;;
5)
    echo 'STOP TINC'
    kill `pidof tincd`
;; 0

*)
   echo "xep" > /dev/null
;;
esac


