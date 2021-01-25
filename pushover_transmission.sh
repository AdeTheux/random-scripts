#!/bin/sh
#-F "sound=cashregister" \ 

curl -s \
	-F "token=abc" \
	-F "user=xyz" \
	-F "title=✅ Transmission download finished" \
	-F "message=$TR_TORRENT_NAME ($TR_TIME_LOCALTIME)" \
	http://api.pushover.net/1/messages > /dev/null
