#!/bin/bash

USERNAME=USER
PASSWORD=PASS
HOSTNAME=DOMAIN.dyndns.org
LOGFILE=/tmp/dyndns_lastip.log
STOREDIPFILE=/tmp/dyndns_currentip.log

if [ ! -e $STOREDIPFILE ]; then
 touch $STOREDIPFILE
fi

NEWIP=$(curl https://icanhazip.com/)
STOREDIP=$(cat $STOREDIPFILE)

if [ "$NEWIP" != "$STOREDIP" ]; then
 RESULT=$(curl -o "$LOGFILE" -s "https://$USERNAME:$PASSWORD@members.dyndns.org/nic/update?hostname=$HOSTNAME&myip=$NEWIP")

 LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"
 echo $NEWIP > $STOREDIPFILE
else
 LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] No IP change"
fi

echo $LOGLINE >> $LOGFILE

exit 0