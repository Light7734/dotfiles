#!/bin/bash

REPO="$(git rev-parse --show-toplevel)"
CONF="$HOME/.config/"

rm -rvf "$REPO/btop"
rm -rvf "$REPO/nvim"
rm -rvf "$REPO/kitty"
rm -vf "$REPO/zshrc.sh"
rm -vf "$REPO/hyfetch.json"
rm -vf "$REPO/gitconfig"
rm -vf "$REPO/wallpapers"

cp -rv "$CONF/btop" "$REPO/btop"
cp -rv "$CONF/nvim" "$REPO/nvim"
cp -rv "$CONF/kitty" "$REPO/kitty"
cp -v "$CONF/hyfetch.json" "$REPO/hyfetch.json"
cp -rv "$HOME/pictures/wallpapers/" "$REPO/wallpapers"
cp -v "$HOME/.zshrc" "$REPO/zshrc.sh"
cp -v "$HOME/.gitconfig" "$REPO/gitconfig"
