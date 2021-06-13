#!/usr/bin/env bash

# Install this with paru for conveniance
paru -S libgccjit

# Here we need to edit the packagefile to enable JIT
git clone https://aur.archlinux.org/emacs-git.git
cd emacs-git
# Enable JIT compilation
sed -i 's/JIT=/JIT="YES"/g' PKGBUILD
makepkg -si

# Tangle our Emacs Config & Install Doom Emacs
emacs --batch --eval "(progn (require 'org) (setq org-confirm-babel-evaluate nil) (org-babel-tangle-file \"~/.config/doom/config.org\"))"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install; ~/.config/doom/setup.sh
