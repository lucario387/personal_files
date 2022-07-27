#!/usr/bin/env bash

# TODO: Add better ways to control backup commands
if [ "$USER" = "root" ] ; then 
  echo "Running as root. Will not backup files"
  exit 1 
fi



kitty_backup(){
  if [ -d ~/.config/kitty ] ; then 
    cp -ru "$HOME/.config/kitty" "$HOME/dotfiles/.config"
  fi
  return 0
}

vim_config_backup(){
  local cwd="$PWD"
  if [ -d "$HOME/.config/nvim" ] ; then 
    rm -rf "$cwd/.config/nvim/"
    cp -rf "$HOME/.config/nvim/" "$cwd/.config/"
  fi
  cp -u "$HOME/.vimrc" "$cwd/"
  return 0
}

# Backup omz config
omz_backup() {
  cp -u "$HOME/.p10k.zsh" "$HOME/.zshrc" "$HOME/dotfiles"
  return 0
}

# cp "$HOME/.shell.pre-oh-my-zsh" "$HOME/dotfiles/.shell.pre-oh-my-zsh"

kitty_backup
vim_config_backup 
omz_backup

unset -f reborn_backup kitty_backup vim_config_backup omz_backup
exit 0
