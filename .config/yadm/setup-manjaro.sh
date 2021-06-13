#!/usr/bin/env bash

# Install Paru for easy AUR access
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
