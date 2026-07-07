#!/bin/bash

STATE_FILE="/tmp/hypr_monitor_cycle"

MON1="eDP-1"
MON2="DP-2"

if [ ! -f "$STATE_FILE" ]; then
    echo "all" > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

case "$STATE" in
    all)
        # Only MON1
        hyprctl keyword monitor "$MON1,preferred,auto,1"
        hyprctl keyword monitor "$MON2,disable"
        echo "mon1" > "$STATE_FILE"
        ;;
    mon1)
        # Only MON2
        hyprctl keyword monitor "$MON1,disable"
        hyprctl keyword monitor "$MON2,preferred,auto,1"
        echo "mon2" > "$STATE_FILE"
        ;;
    mon2)
        # Enable both
        hyprctl keyword monitor "$MON1,preferred,auto,1"
        hyprctl keyword monitor "$MON2,preferred,auto,1"
        echo "all" > "$STATE_FILE"
        ;;
esac
