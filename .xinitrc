# sh ~/.screenlayout/two-monitor.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option ctrl:nocaps
setxkbmap us,se -option "grp:alt_shift_toggle"
sh $HOME/.fehbg
# picom --daemon
bspwm

# Init fonts
xset +fp $HOME/.local/share/fonts
xset fp rehash
