#!/usr/bin/bash
icons=(󱘖 )
icon=$(cat /sys/class/power_supply/AC/online)
echo ${icons[$icon]}
