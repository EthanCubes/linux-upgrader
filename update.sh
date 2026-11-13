#! /bin/bash

echo "Starting full system update"

flatpak update # works for most linux systems

# Arch Linux
command -v yay >/dev/null 2>&1 && yes | yay
command -v yay >/dev/null 2>&1 || sudo pacman -Syu --noconfirm
