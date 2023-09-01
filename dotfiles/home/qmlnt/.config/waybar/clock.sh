#!/usr/bin/bash
text=$(date +'%-d %a %H:%M')
alt=$(date +'%a/%b %-d.%m.%Y %H:%M')
echo "{\"text\": \"$text\", \"alt\": \"$alt\"}"
