#!/bin/bash


BACKUP_PATH=$(dirname $(readlink -f "$0"))

cp -r "$BACKUP_PATH/*" "$HOME/.config/nvim/"
# cd "$BACKUP_PATH" || exit 1
# cp -r * "$HOME/.config/nvim/"
# cd - || exit 1
