#!/usr/bin/env bash

pkill polybar
while pgrep polybar >/dev/null; do sleep 1; done

export MONITOR=eDP-1
polybar main >$XDG_DATA_HOME/polybar.log 2>&1 &
echo 'Polybar launched monitor2'
