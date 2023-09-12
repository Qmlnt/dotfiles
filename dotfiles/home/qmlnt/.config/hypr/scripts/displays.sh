#!/usr/bin/bash

for MON in "$@";
do
    if [[ ${MON::1} == '-' ]]; then
        STR+="monitor =${MON:1}, disable\n"
    else
        STR+="monitor = $MON, preferred, auto, 1\n"
    fi
done

printf "$STR" > ~/.config/hypr/displays.conf
