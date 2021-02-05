#!/bin/bash

CHANNEL="#household"
MSG="🗳 Torrent download completed: $TR_TORRENT_NAME ($TR_TIME_LOCALTIME)"

PAYLOAD="payload={\"channel\": \"$CHANNEL\", \"text\": \"$MSG\"}"
HOOK=https://hooks.slack.com/services/x/y/z

curl -X POST --data-urlencode "$PAYLOAD" "$HOOK"