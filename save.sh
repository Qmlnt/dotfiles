cd /home/qmlnt/Backups/dotfiles/

qncm -if save_list_user --to dotfiles
echo
tree -a dotfiles | tee dotfiles_tree
date +'%S:%M:%H %e/%d/%y' >> dotfiles_tree

git status --short
git add *
git status --short
git commit -m "`date +'%S:%M:%H %e/%d/%y'`"
git push origin

cd -
