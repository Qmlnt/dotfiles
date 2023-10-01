#!/usr/bin/bash
sleep 1.5
killall -s0 wl-screenrec
if [[ $? == 0 ]]; then
    echo '󰑋 '$(ps aux | grep -Po '\d:\d\d wl-screenrec' | wc -l)
else
    echo '-'
fi
