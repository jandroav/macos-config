#!/usr/bin/env sh
# =============================================================================
# spotifyIndicator.sh — Show currently playing Spotify track
# =============================================================================
# Polls Spotify every 1 second (update_freq=1 in sketchybarrc).
# Uses AppleScript to check if Spotify is running and playing.
# Displays "Track - Artist" (or "Track - Album" if artist is empty).
# Hides itself and the spot_logo when Spotify isn't actively playing.
# =============================================================================

# Check if Spotify is running (returns "0" if running, empty otherwise)
RUNNING=$(osascript -e 'if application "Spotify" is running then return 0')
if [ "$RUNNING" == "" ]; then
  RUNNING=1
fi

PLAYING=1
TRACK=""
ALBUM=""
ARTIST=""

# If Spotify is running, check playback state and get track info
if [ "$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to get player state')" == "playing" ]; then
  PLAYING=0
  TRACK=$(osascript -e 'tell application "Spotify" to get name of current track')
  ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track')
  ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track')
fi

if [ $RUNNING -eq 0 ] && [ $PLAYING -eq 0 ]; then
  # Spotify is running and playing — show track info and make items visible
  if [ "$ARTIST" == "" ]; then
    sketchybar --set $NAME label=" $TRACK - $ALBUM" --set '/spot.*/' drawing=on
  else
    sketchybar --set $NAME label=" $TRACK - $ARTIST" --set '/spot.*/' drawing=on
  fi
else
  # Not playing or not running — hide all Spotify-related items
  sketchybar --set '/spot.*/' drawing=off
fi
