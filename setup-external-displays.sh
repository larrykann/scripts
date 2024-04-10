#!/bin/bash

# Your external monitor ports
EXTERNAL_MONITOR_1="DP-1-0.1"
EXTERNAL_MONITOR_2="DP-1-0.2"

# Check if the first external monitor is connected
if xrandr | grep "$EXTERNAL_MONITOR_1 connected"; then
    xrandr --output $EXTERNAL_MONITOR_1 --auto --right-of eDP
fi

# Check if the second external monitor is connected
if xrandr | grep "$EXTERNAL_MONITOR_2 connected"; then
    # If both monitors are connected, place the second to the right of the first
    if xrandr | grep "$EXTERNAL_MONITOR_1 connected"; then
        xrandr --output $EXTERNAL_MONITOR_2 --auto --right-of $EXTERNAL_MONITOR_1
    else
        xrandr --output $EXTERNAL_MONITOR_2 --auto --right-of eDP
    fi
fi

# Ensure the laptop display is always on
xrandr --output eDP --auto

