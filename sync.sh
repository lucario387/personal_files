#!/bin/bash

if [ "$USER" = "root" ] ; then 
  echo "Running as root. Will not sync"
  exit 1
fi
  

cd "$HOME/dotfiles" || exit 0 
"$HOME"/dotfiles/backup.sh 
if [[ -n $(git status -s 2>/dev/null) ]] ; then 
  # Only sync when there are updated files in the tree
  git add . 
  git commit -m "Sync @ $(date)" > /dev/null 2>&1 
  # git push > /dev/null 2>&1
fi

# if [[ -n $(git rev-list --left-right --pretty=oneline main...origin/main | wc -l) ]] ; then 
#   git push > /dev/null 2>&1
# fi

exit 0
