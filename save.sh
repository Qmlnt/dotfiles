cd /home/qmlnt/Backups/dotfiles/

sudo -k qncm -if list_system --to dotfiles
printf "\nSystem done!\n"
qncm -if list_user --to dotfiles
printf "\nTree:"
tree -a dotfiles | tee tree
# date +'%S:%M:%H %e/%d/%y' >> tree

printf "\n\nChanges:\n"
git status --short
printf "\nAdding:\n"
git add --all
printf "\nAdded:\n"
git status --short
prinf "\nCommitting:\n"
git commit -m "`date +'%S:%M:%H %e/%d/%y'`"
printf "\nPushing:\n"
git push origin
printf "\nDONE!\a"

cd -
