#!/bin/bash
MSG="Torrent download completed: $TR_TORRENT_NAME ($TR_TIME_LOCALTIME)"
slack-webhook-household -l "good" -t ":inbox_tray: Transmission" -m "$MSG"