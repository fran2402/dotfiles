#!/bin/bash

# Run hyprlock in the background
hyprlock &

# Store the PID of hyprlock to kill the script once it exits
HYPRLOCK_PID=$!

# Create a temporary config file for xbindkeys (or sxhkd)
TEMP_XBINDKEYS_CONFIG=$(mktemp)

# Set up key bindings
cat <<EOL > "$TEMP_XBINDKEYS_CONFIG"
# Keybinding for logout (L key)
"pkill -KILL -u $(whoami)"
  l

# Keybinding for shutdown (S key)
"shutdown now"
  s

# Keybinding for restart (R key)
"reboot"
  r

# Keybinding for sleep (H key)
"systemctl suspend"
  h
EOL

# Start xbindkeys with the temporary config file
xbindkeys -f "$TEMP_XBINDKEYS_CONFIG" &

# Monitor hyprlock process
while kill -0 $HYPRLOCK_PID 2>/dev/null; do
    sleep 1
done

# Once hyprlock is exited, clean up the temporary xbindkeys config
killall xbindkeys
rm -f "$TEMP_XBINDKEYS_CONFIG"

