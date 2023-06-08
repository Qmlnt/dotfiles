cd /home/qmlnt/Backups/dotfiles/

sudo -k qncm -if list_system --to dotfiles
qncm -if list_user --to dotfiles
printf "\nSystem done!\n"
tree -a dotfiles | tee tree
# date +'%S:%M:%H %e/%d/%y' >> tree

printf "\n\nChanges:"
git status --short
git add --all
printf "\nAdded:"
git status --short
git commit -m "`date +'%S:%M:%H %e/%d/%y'`"
printf "\nPushing:"
git push origin

cd -
