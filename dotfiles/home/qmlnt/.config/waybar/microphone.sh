#!/usr/bin/bash
STATE=$(pactl get-source-mute @DEFAULT_SOURCE@)
NAME=$(pactl get-default-source | grep -Po '(?<=\.).*?(?=[_-]\d)')
VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -Po '\d*(?=%)' | head -n1)

ICON='󱦊'; CLASS='unknown'
case $STATE in
    "Mute: yes") ICON='󰍭'; CLASS='muted';;
    "Mute: no") ICON='󰍬'; CLASS='unmuted';;
esac

echo '{"text": "'$ICON'", "alt": "'$ICON $VOL%'", "tooltip": "'${NAME//[-_]/ }'", "class": "'$CLASS'"}'
