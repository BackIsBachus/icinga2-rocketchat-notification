#!/bin/bash

ICINGA_HOSTNAME="<YOUR_ICINGAWEB2_HOSTNAME>"
ROCKETCHAT_WEBHOOK_URL="<YOUR_ROCKETCHAT_WEBHOOK_INTEGRATION_URL>"

#Set the message icon based on ICINGA service state
if [ "$SERVICESTATE" = "CRITICAL" ]
then
    ICON=":exclamation:"
elif [ "$SERVICESTATE" = "WARNING" ]
then
    ICON=":warning:"
elif [ "$SERVICESTATE" = "OK" ]
then
    ICON=":white_check_mark:"
elif [ "$SERVICESTATE" = "UNKNOWN" ]
then
    ICON=":question:"
else
    ICON=":white_medium_square:"
fi

#Send message to Rocket.Chat
PAYLOAD="payload={\"text\": \"${ICON} ${NOTIFICATIONTYPE} [${HOSTDISPLAYNAME}](https://${ICINGA_HOSTNAME}/icingaweb2/monitoring/host/services?host=${HOSTNAME}) ([${SERVICEDISPLAYNAME}](<https://${ICINGA_HOSTNAME}/icingaweb2/monitoring/service/show?host=${HOSTNAME}&service=${SERVICEDESC})): *${SERVICESTATE}* | ${SERVICEOUTPUT} | [ *${NOTIFICATIONAUTHORNAME}* ] ${NOTIFICATIONCOMMENT} \"}"
curl --connect-timeout 30 --max-time 60 -s -S -X POST --data-urlencode "${PAYLOAD}" "${ROCKETCHAT_WEBHOOK_URL}"
