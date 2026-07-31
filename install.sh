#!/bin/bash

REPO="$(git rev-parse --show-toplevel)"
CONF="$HOME/.config/"

if [ -d "$REPO/backup" ]; then
  echo "$REPO/backup already exists, please handle what happened in previous runs before re-attempting and deleting the backup."
fi

mkdir .backup/

echo 'Creating backup...'
cp -rv "$CONF/btop" "$REPO/backup/btop"
cp -rv "$CONF/nvim" "$REPO/backup/nvim"
cp -rv "$CONF/kitty" "$REPO/backup/kitty"

echo 'Removing currently installed config files...'
rm -rv "$CONF/btop"
rm -rv "$CONF/nvim"
rm -rv "$CONF/kitty"

echo 'Installing the new config...'
cp -rv "$REPO/btop" "$CONF/btop" 
cp -rv "$REPO/nvim" "$CONF/nvim" 
cp -rv "$REPO/kitty" "$CONF/kitty" 
