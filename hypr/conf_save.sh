#!/bin/bash

# Open Hyprland configuration in nvim
nvim ~/.config/hypr/hyprland.conf &

# Wait for nvim to launch
sleep 0.1

# Simulate Ctrl+S (save)
xdotool key ctrl+s
sleep 0.1

# Simulate Super+Q (Windows key + Q)
xdotool key Super_L+q

