#!/bin/bash

# Handle click events for Spotify controls
case "$BUTTON" in
    "right")
        # Right click: Next track
        osascript -e "tell application \"Spotify\" to next track"
        ;;
    "left")
        # Left click: Play/Pause toggle
        osascript -e "tell application \"Spotify\" to playpause"
        ;;
    "middle")
        # Middle click: Previous track  
        osascript -e "tell application \"Spotify\" to previous track"
        ;;
esac

# Update the display after action
sleep 0.1
$CONFIG_DIR/plugins/spotify.sh