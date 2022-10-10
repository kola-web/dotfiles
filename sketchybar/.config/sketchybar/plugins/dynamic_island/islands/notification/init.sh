#!/usr/bin/env sh

NOTIFICATION_DATABASE="/private/var/folders/ht/y9z4p2ts70gd0ndtvm75w8_m0000gn/0/com.apple.notificationcenter/db2"
# CHANGE THIS LINE ^^^^^^^^^^^^^

# run python script to check for notifications
NotificationCheckScript="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/FetchNotifications.py"
pkill -f $NotificationCheckScript
python3 $NotificationCheckScript $NOTIFICATION_DATABASE &
