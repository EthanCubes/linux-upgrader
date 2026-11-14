#! /bin/bash

# Debug mode (for developers)
debug_mode="false"
ls ~/debug_mode >/dev/null 2>&1 && debug_mode="true"

# test for package manager
package_manager="none"
command -v pacman >/dev/null 2>&1 && package_manager="pacman"
command -v apt >/dev/null 2>&1 && package_manager="apt"
command -v dnf >/dev/null 2>&1 && package_manager="dnf"

# check for internet connection
command -v ping https://archlinux.org/ >/dev/null 2>&1 || /
if [ $debug_mode = "false" ] ; then
    echo "No internet connection" 1>&2
    exit 101
fi

# Universal flatpak
flatpak_installed="false"
command -v flatpak >/dev/null 2>&1 && yes | flatpak update # works for most linux systems
command -v flatpak >/dev/null 2>&1 && flatpak_installed="true"

# Arch Linux pacman
if [ $package_manager = "pacman" ] ; then
    command -v yay >/dev/null 2>&1 && yes | yay # if yay is installed, run yes | yay to update system
    command -v paru >/dev/null 2>&1 && yes | paru -Syu # same thing but with paru instead
    command -v yay >/dev/null 2>&1 || command -v paru >/dev/null 2>&1 || sudo pacman -Syu --noconfirm # fallback to pacman if yay and paru are both not installed
fi

# Debian apt
if [ $package_manager = "apt" ] ; then
    sudo apt update # fetches information
    sudo apt upgrade -y
fi

# Fedora dnf
if [ $package_manager = "dnf" ] ; then
    sudo dnf update
    sudo dnf upgrade -y
fi

if [ $package_manager = "none" ] && [ $flatpak_installed = "false" ] ; then
    echo "No supported package manager detected!" 1>&2
    exit 1
fi
