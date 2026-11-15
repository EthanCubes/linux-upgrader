#!/bin/bash

set -euo pipefail

# test for package manager
package_manager="none"
command -v pacman >/dev/null 2>&1 && package_manager="pacman"
command -v apt >/dev/null 2>&1 && package_manager="apt"
command -v yum >/dev/null 2>&1 && package_manager="yum"
command -v dnf >/dev/null 2>&1 && package_manager="dnf"

# Universal flatpak
flatpak_installed="false"
command -v flatpak >/dev/null 2>&1 && flatpak_installed="true"
if [ "$flatpak_installed" = "true" ] ; then
    flatpak update -y
fi

# Arch pacman
if [ "$package_manager" = "pacman" ] ; then
    yay_installed="false"
    paru_installed="false"
    command -v yay >/dev/null 2>&1 && yay_installed="true"
    command -v paru >/dev/null 2>&1 && paru_installed="true"
    if [ "$yay_installed" = "true" ] ; then
        yay -Syu --noconfirm
    else
        if [ "$paru_installed" = "true" ] ; then
            paru -Syu --noconfirm
        else 
            sudo pacman -Syu --noconfirm
        fi
    fi
fi

# Debian apt
if [ "$package_manager" = "apt" ] ; then
    sudo apt update
    sudo apt upgrade -y
fi

# RHEL yum
if [ "$package_manager" = "yum" ] ; then
    sudo yum update -y
fi

# Fedora dnf
if [ "$package_manager" = "dnf" ] ; then
    sudo dnf upgrade -y
fi

# No package manager
if [ "$package_manager" = "none" ] && [ "$flatpak_installed" = "false" ] ; then
    echo "No supported package manager detected!" 1>&2
    exit 1
fi
