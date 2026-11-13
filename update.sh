#! /bin/bash

flatpak update # works for most linux systems

# Arch Linux
command -v yay >/dev/null 2>&1 && yes | yay # if yay is installed, run yes | yay to update system
command -v yay >/dev/null 2>&1 || sudo pacman -Syu --noconfirm # fallback to pacman if yay is not installed
