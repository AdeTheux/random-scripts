#!/bin/sh
#FreeDNS updater script

#Variables
DOMAINSWI="x"
DOMAIN="x.mooo.com"
UPDATEURL="http://x:x@freedns.afraid.org/nic/update?hostname=$DOMAIN&myip=$CURRENT"

# Get the IP of Swisscom domain
CURRENT=$(nslookup $DOMAINSWI|tail -n2|grep A|sed s/[^0-9.]//g)
# Get the IP of the FreeDNS domain
REGISTERED=$(nslookup $DOMAIN|tail -n2|grep A|sed s/[^0-9.]//g)
#Compare, and update if not up-to-date

   [ "$CURRENT" != "$REGISTERED" ] && {
     wget -q -O /dev/null $UPDATEURL$CURRENT
     echo "$DOMAIN IP updated from $REGISTERED to $CURRENT on $(date)" >> /var/log/dns/dns_updater.log
     slack-webhook-household -l "good" -t "🏡 DNS updated" -m ":electric_plug: Home backup DNS updated"
   }
   