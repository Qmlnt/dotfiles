#!/usr/bin/zsh
cd /home/qmlnt/Backups/dotfiles/

doas qncm -if list_system --to dotfiles
qncm -if list_user --to dotfiles
printf "\nTree:\n"
tree -a --dirsfirst dotfiles | tee tree

printf "\n\nChanges:\n"
git status --short
git add --all
printf "\nAdded:\n"
git status --short
printf "\nCommitting:\n"
git commit -m "$(date +'%-d.%m.%Y %H:%M')"
printf "\nPushing:\n"
git push origin
printf "\nDONE!\n\a"

cd -
