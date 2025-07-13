#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  # Set color based on volume level
  if [ "$VOLUME" -gt 70 ]; then
      COLOR="0xffff6b6b"  # Red for high volume
  elif [ "$VOLUME" -gt 30 ]; then
      COLOR="0xffffab00"  # Orange for medium volume
  elif [ "$VOLUME" -gt 0 ]; then
      COLOR="0xff51d88a"  # Green for low volume
  else
      COLOR="0xff666666"  # Gray for muted
  fi

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾"
    ;;
    [3-5][0-9]) ICON="󰖀"
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿"
    ;;
    *) ICON="󰖁"
  esac

  sketchybar --set "${NAME:-volume}" icon="$ICON" label="$VOLUME%" icon.color="$COLOR"
fi