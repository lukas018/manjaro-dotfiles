#!/usr/bin/env bash

pkill polybar
while pgrep polybar >/dev/null; do sleep 1; done

# Show the same bar on all monitors
for MONITOR in $(xrandr | grep " connected " | awk '{ print$1 }')
do
    export MONITOR=$MONITOR
    polybar main >$XDG_DATA_HOME/polybar.log 2>&1 &
    echo "Polybar launched in ${MONITOR}"
done
