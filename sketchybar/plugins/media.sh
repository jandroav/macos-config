#!/usr/bin/env sh
# =============================================================================
# media.sh — Show non-Spotify media playback (YouTube, Apple Music, etc.)
# =============================================================================
# Uses nowplaying-cli to get the currently playing media from any app.
# Intentionally hides when Spotify is the source (spotifyIndicator.sh handles
# that separately to avoid duplicate display).
#
# Truncates long titles (>25 chars) and labels (>40 chars) with an ellipsis.
# Hides itself and the media_logo when nothing is playing.
# =============================================================================

APP=$(nowplaying-cli get appName 2>/dev/null | head -1)
STATE=$(nowplaying-cli get playbackRate 2>/dev/null | head -1)

# Hide when: no app reported, playback paused (rate=0), or Spotify is playing
if [ -z "$APP" ] || [ "$STATE" = "0" ] || [ "$APP" = "Spotify" ]; then
  sketchybar --set '/media.*/' drawing=off
  exit 0
fi

TITLE=$(nowplaying-cli get title 2>/dev/null | head -1)
ARTIST=$(nowplaying-cli get artist 2>/dev/null | head -1)

# Hide if there's no title to show
if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
  sketchybar --set '/media.*/' drawing=off
  exit 0
fi

# Truncate long titles to keep the bar readable
if [ ${#TITLE} -gt 25 ]; then
  TITLE="$(echo "$TITLE" | cut -c1-25)…"
fi

if [ -n "$ARTIST" ] && [ "$ARTIST" != "null" ]; then
  LABEL="$TITLE - $ARTIST"
else
  LABEL="$TITLE"
fi

# Truncate the full label too
if [ ${#LABEL} -gt 40 ]; then
  LABEL="$(echo "$LABEL" | cut -c1-40)…"
fi

sketchybar --set "$NAME" label=" $LABEL" --set '/media.*/' drawing=on
