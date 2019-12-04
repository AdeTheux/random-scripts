#!/bin/sh
#FreeDNS updater script

#Variables
DOMAINSWI="NAME.internet-box.ch"
DOMAIN="SUBDOMAIN.mooo.com"
UPDATEURL="http://USER:PASS@freedns.afraid.org/nic/update?hostname=$DOMAIN&myip="

# Get the IP of Swisscom domain
CURRENT=$(nslookup $DOMAINSWI|tail -n2|grep A|sed s/[^0-9.]//g)
# Get the IP of the FreeDNS domain
REGISTERED=$(nslookup $DOMAIN|tail -n2|grep A|sed s/[^0-9.]//g)
#Compare, and update if not up-to-date

   [ "$CURRENT" != "$REGISTERED" ] && {
      wget -q -O /dev/null $UPDATEURL$CURRENT
      echo "DNS updated from $REGISTERED to $CURRENT on: $(date)" >> dns_log.txt
}