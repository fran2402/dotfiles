#!/bin/bash

# Take a screenshot using grim and save it temporarily
grim -g "$(slurp -d)" /tmp/screenshot.png

# Remove a 1-pixel border from the screenshot using magick
magick /tmp/screenshot.png -crop +1+1 -crop -1-1 /tmp/trimmed_screenshot.png

# Copy the modified screenshot to the clipboard
wl-copy < /tmp/trimmed_screenshot.png

# Cleanup temporary files
rm /tmp/screenshot.png /tmp/trimmed_screenshot.png

