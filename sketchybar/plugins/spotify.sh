#!/bin/bash

# Check if Spotify is running
if ! pgrep -x "Spotify" > /dev/null; then
    sketchybar --set spotify drawing=off
    exit 0
fi

# Get Spotify state
SPOTIFY_STATE=$(osascript -e "tell application \"Spotify\" to player state as string" 2>/dev/null)

if [[ $SPOTIFY_STATE == "" ]] || [[ $SPOTIFY_STATE == "stopped" ]]; then
    sketchybar --set spotify drawing=off
    exit 0
fi

# Get track information
TRACK=$(osascript -e "tell application \"Spotify\" to name of current track as string" 2>/dev/null)
ARTIST=$(osascript -e "tell application \"Spotify\" to artist of current track as string" 2>/dev/null)

# Set icon based on play state
if [[ $SPOTIFY_STATE == "playing" ]]; then
    ICON="󰓇"  # Spotify icon
else
    ICON="󰓇"  # Spotify icon
fi

# Truncate long text to maintain clean look
if [[ ${#TRACK} -gt 20 ]]; then
    TRACK="${TRACK:0:17}..."
fi

if [[ ${#ARTIST} -gt 15 ]]; then
    ARTIST="${ARTIST:0:12}..."
fi

# Update the item
sketchybar --set spotify \
    drawing=on \
    icon="$ICON" \
    label="$ARTIST - $TRACK"