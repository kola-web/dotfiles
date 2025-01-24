#!/bin/sh

# start_language="/usr/bin/pbpaste | trans -id"

/usr/bin/pbpaste | /opt/homebrew/bin/trans -x 127.0.0.1:1090 | LC_CTYPE=UTF-8 /usr/bin/pbcopy
# echo "Script executed at $(date)" >> /Users/lijialin/.config/skhd/a.log
