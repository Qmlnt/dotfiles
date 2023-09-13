#!/usr/bin/bash
ICONS=(󱘖 )
STATE=$(cat /sys/class/power_supply/AC/online)
echo ${ICONS[$STATE]}
