#!/bin/bash
MSG="Download completed: $TR_TORRENT_NAME ($TR_TIME_LOCALTIME)"
slack-webhook-household -l "good" -t "🏡 Transmission" -m ":inbox_tray: $MSG"