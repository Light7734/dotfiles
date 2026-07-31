#!/bin/bash

REPO="$(git rev-parse --show-toplevel)"
CONF="$HOME/.config/"

rm -rv "$REPO/btop"
rm -rv "$REPO/nvim"
rm -rv "$REPO/kitty"

cp -rv "$CONF/btop" "$REPO/btop"
cp -rv "$CONF/nvim" "$REPO/nvim"
cp -rv "$CONF/kitty" "$REPO/kitty"

