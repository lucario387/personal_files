#!/usr/bin/env bash

# TODO: Add better ways to control backup commands
if [ "$USER" = "root" ]; then
	echo "Running as root. Will not backup files"
	exit 1
fi

PWD=$(dirname $(readlink -f "$0"))

kitty_backup() {
	if [ -d ~/.config/kitty ]; then
		# cp -ru "$HOME/.config/kitty" "$PWD/.config"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/kitty/" "$PWD/.config/kitty"
	fi
	return 0
}

vim_config_backup() {
  NVIM_PATH="$HOME/.config/nvim"
	if [ -d "$NVIM_PATH" ]; then
		# rsync --delete --inplace --no-whole-file --recursive --qtmUp "$NVIM_PATH" "$PWD/.config/nvim"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/" "$PWD/.config/nvim"

		# rm -rf "$cwd/.config/nvim/"
		# cp -rf "$HOME/.config/nvim/" "$cwd/.config/"
	fi
	cp "$HOME/.vimrc" "$PWD/"
	return 0
}

# Backup omz config
omz_backup() {
	cp "$HOME/.zshrc" "$PWD"
	return 0
}

kitty_backup
vim_config_backup
omz_backup

unset -f reborn_backup kitty_backup vim_config_backup omz_backup
exit 0
