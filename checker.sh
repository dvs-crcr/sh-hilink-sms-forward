#!/bin/bash
if [[ "$(/bin/sh check_proc.sh red.sh)" == "true" ]];then
   echo ""
else
   /bin/sh /root/red.sh > /dev/null &
fi
if [[ "$(/bin/sh check_proc.sh sms.sh)" == "true" ]];then
   echo ""
else
   /bin/sh /root/sms.sh > /dev/null &
fi
