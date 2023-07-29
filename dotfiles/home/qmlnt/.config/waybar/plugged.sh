#!/usr/bin/zsh
icons=(󱘖 )
icon=$(($(cat /sys/class/power_supply/AC/online)+1))
echo ${icons[$icon]}
