#!/usr/bin/bash
TEXT=$(date +'%-d %a %H:%M')
ALT=$(date +'%a/%b %-d.%m.%Y %H:%M')
echo '{"text": "'$TEXT'", "alt": "'$ALT'"}'
