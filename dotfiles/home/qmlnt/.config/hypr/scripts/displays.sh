#!/usr/bin/bash

for MON in "$@";
do
    if [[ ${MON::1} == '-' ]]; then
        STR+="monitor =${MON:1}, disable\n"
    else
        hyprctl keyword "monitor $MON,prefferred,auto,1"
        STR+="monitor = $MON, preferred, auto, 1\n"
    fi
done
if [[ $1 ]]; then STR=${STR/auto/0x0}; fi


sleep 2
printf "$STR" > ~/.config/hypr/displays.conf

if [[ $(hyprctl getoption misc:disable_autoreload) =~ int:\ 1 ]];
then hyprctl reload; fi

# Restart programs that have issues
sleep 2
hyprctl dispatch -- exec "killall gammastep && gammastep -m wayland -PO 4000"
hyprctl dispatch -- exec "killall hyprpaper && hyprpaper"
hyprctl dispatch -- exec "killall waybar    && waybar"

hyprctl notify 5 1500 "rgb(aa44ff)" " displays"
