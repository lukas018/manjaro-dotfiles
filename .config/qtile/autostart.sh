#!/usr/bin/env bash 
# 
# Using bash in the shebang rather than /bin/sh, which should
# be avoided as non-POSIX shell users (fish) may experience errors.

# lxsession &
# picom --experimental-backends &

# Reload pywal color-scheme
wal -R
# Set the wallpaper
sh ~/.fehbg
# urxvtd -q -o -f &
# volumeicon &
# nm-applet &
# sh ~/.screenlayout/two-monitor.sh
