#!/bin/bash

REPO="$(git rev-parse --show-toplevel)"
CONF="$HOME/.config/"

rm -rv "$REPO/btop"
rm -rv "$REPO/nvim"
rm -rv "$REPO/kitty"
rm -v "$REPO/zshrc.sh"
rm -v "$REPO/hyfetch.json"
rm -v "$REPO/gitconfig"

cp -rv "$CONF/btop" "$REPO/btop"
cp -rv "$CONF/nvim" "$REPO/nvim"
cp -rv "$CONF/kitty" "$REPO/kitty"
cp -v "$CONF/hyfetch.json" "$REPO/hyfetch.json"
cp -v "$HOME/.zshrc" "$REPO/zshrc.sh"
cp -v "$HOME/.gitconfig" "$REPO/gitconfig"
