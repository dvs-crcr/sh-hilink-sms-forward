#!/bin/bash
IP=$(cat ip)
KEY=$(cat api_key)
URL="http://${IP}/api/sms"
# CHECK TIME IN SEC
CHECK_SMS=10
PID=$$
XML="last_sms.xml"
echo $PID > /root/sms.pid
while true; do
    echo $(/bin/sh /root/hilink.sh get_sms 1 | while read line; do echo -n "$line\\n"; done) > ${XML}
    COUNT=$(awk -F "[><]" '{print $7}' ${XML})
    if [ "$COUNT" == "1" ]; then
        INDEX=$(awk -F "[><]" '{print $19}' ${XML})
        PHONE=$(awk -F "[><]" '{print $23}' ${XML})
        CONTENT=$(awk -F "[><]" '{print $27}' ${XML})
        SREQ=$(curl -s -X POST "${URL}" -H "Content-Type: application/json" -d "{\"key\":\"${KEY}\",\"phone\":\"${PHONE}\",\"msg\":\"${CONTENT}\"}" 2>/dev/null)
        if [ "$SREQ" == "1" ]; then
            /bin/sh /root/hilink.sh delete_sms $INDEX > /dev/null
        fi
    fi
    sleep $CHECK_SMS
done
