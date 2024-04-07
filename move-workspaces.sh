#!/bin/bash

# Define the primary monitor (your laptop monitor). 
# You can get the name via `xrandr` or `i3-msg -t get_outputs`
PRIMARY_MONITOR="eDP"

# Use i3-msg to move each workspace to the primary monitor
i3-msg -t get_workspaces | jq -r '.[] | .name' | while read -r workspace; do
    i3-msg "workspace $workspace; move workspace to output $PRIMARY_MONITOR"
done

