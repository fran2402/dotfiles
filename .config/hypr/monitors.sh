#!/bin/bash

while true; do
    # Get connected monitors
    CONNECTED_MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

    # Check if HDMI-A-1 or DP-2 is connected
    if echo "$CONNECTED_MONITORS" | grep -q "HDMI-A-1"; then
        echo "HDMI-A-1 detected. Disabling eDP-1..."
        hyprctl keyword monitor "eDP-1, disable"
        hyprpaper &
    elif echo "$CONNECTED_MONITORS" | grep -q "DP-2"; then
        echo "DP-2 detected. Disabling eDP-1..."
        hyprctl keyword monitor "eDP-1, disable"
        hyprpaper &
    else
        echo "No external monitor detected. Keeping eDP-1 enabled..."
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        hyprpaper &
    fi

    # Wait before next check
    sleep 5
done

