#!/usr/bin/env bash

set -e

echo "==> Cloning and running ToiletPaper with automated selections (5, 6, 7)..."
TMP_DIR=$(mktemp -d)
git clone https://github.com/dim-ghub/ToiletPaper.git "$TMP_DIR/ToiletPaper"
cd "$TMP_DIR/ToiletPaper"
chmod +x toiletpaper.sh

# Feed menu inputs: N (deselect all defaults), 5, 6, 7, C (confirm)
printf "N\n5\n6\n7\nC\n" | sudo ./toiletpaper.sh

echo "==> Cleaning up ToiletPaper temporary files..."
cd ~
rm -rf "$TMP_DIR"

echo "==> Installing paru..."
sudo pacman -S --needed --noconfirm paru

echo "==> Installing Hyprland..."
sudo pacman -S --needed --noconfirm hyprland

echo "==> Installing quickshell-git from AUR..."
paru -S --noconfirm quickshell-git

echo "==> Installing midnight-cli-git..."
paru -S --noconfirm midnight-cli-git

echo "==> First pass: Installing midnight-shell-git..."
paru -S --noconfirm midnight-shell-git || true

echo "==> Second pass: Installing midnight-shell-git..."
paru -S --noconfirm midnight-shell-git

echo "==> Cloning custom Caelestia configuration..."
TARGET_DIR="$HOME/.config/caelestia"

rm -rf "$TARGET_DIR"
git clone https://github.com/toi2/caelestia-config "$TARGET_DIR"

echo "==> Fresh installation complete!"
