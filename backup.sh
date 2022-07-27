#!/usr/bin/env bash

# TODO: Add better ways to control backup commands
if [ "$USER" = "root" ]; then
	echo "Running as root. Will not backup files"
	exit 1
fi

kitty_backup() {
	if [ -d ~/.config/kitty ]; then
		# cp -ru "$HOME/.config/kitty" "$HOME/dotfiles/.config"
		rsync --delete --inplace --no-whole-file --recursive -qnptU "$HOME/.config/kitty" "$HOME/dotfiles/.config/"
	fi
	return 0
}

vim_config_backup() {
	if [ -d "$HOME/.config/nvim" ]; then
		# rsync --delete --inplace --no-whole-file --recursive --qtmUp "$HOME/.config/nvim" "$PWD/.config/nvim"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/lua/custom" "$HOME/dotfiles/.config/nvim/lua"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/ftplugin" "$HOME/dotfiles/.config/nvim/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/.luarc.json" "$HOME/dotfiles/.config/nvim/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/after" "$HOME/dotfiles/.config/nvim/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/plugin" "$HOME/dotfiles/.config/nvim/"

		# rm -rf "$cwd/.config/nvim/"
		# cp -rf "$HOME/.config/nvim/" "$cwd/.config/"
	fi
	cp "$HOME/.vimrc" "$PWD/"
	return 0
}

# Backup omz config
omz_backup() {
	cp "$HOME/.p10k.zsh" "$HOME/.zshrc" "$HOME/dotfiles"
	return 0
}

kitty_backup
vim_config_backup
omz_backup

unset -f reborn_backup kitty_backup vim_config_backup omz_backup
exit 0
