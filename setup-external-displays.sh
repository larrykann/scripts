#!/bin/bash

# External monitor ports
EXTERNAL_MONITOR_1="DP-1-0.1"
EXTERNAL_MONITOR_2="DP-1-0.2"

# Check if external monitors are connected
if xrandr | grep "$EXTERNAL_MONITOR_1 connected" && xrandr | grep "$EXTERNAL_MONITOR_2 connected"; then
    # External monitors are connected
    xrandr --output $EXTERNAL_MONITOR_1 --auto --right-of eDP
    xrandr --output $EXTERNAL_MONITOR_2 --auto --right-of $EXTERNAL_MONITOR_1
    xrandr --output eDP --off # Turn off laptop display
else
    # No external monitors found, enable laptop display
    xrandr --output eDP --auto
fi

