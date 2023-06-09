cd /home/qmlnt/Backups/dotfiles/

sudo -k qncm -if list_system --to dotfiles
qncm -if list_user --to dotfiles
printf "\nTree:\n"
tree -aC --dirsfirst dotfiles | tee tree
# date +'%S:%M:%H %e/%d/%y' >> tree

printf "\n\nChanges:\n"
git status --short
git add --all
printf "\nAdded:\n"
git status --short
printf "\nCommitting:\n"
git commit -m "`date +'%S:%M:%H %e/%d/%y'`"
printf "\nPushing:\n"
git push origin
printf "\nDONE!\n\a"

cd -
