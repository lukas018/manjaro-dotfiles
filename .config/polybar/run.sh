#!/usr/bin/env bash


pkill polybar
while pgrep polybar >/dev/null; do sleep 1; done

# Get the working directory of this script
DIR="$(cd "$(dirname "$0")" && pwd)"

# Show the same bar on all monitors
for MONITOR in $(xrandr | grep " connected " | awk '{ print$1 }')
do
    export MONITOR=$MONITOR
    polybar main --config=$DIR/config.ini 2>&1 | tee -a $XDG_DATA_HOME/polybar.log & disown
    echo "Polybar launched in ${MONITOR}"
done
