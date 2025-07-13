#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Set color based on battery level
if [ "$PERCENTAGE" -gt 50 ]; then
    COLOR="0xff51d88a"  # Green for good battery
elif [ "$PERCENTAGE" -gt 20 ]; then
    COLOR="0xffffab00"  # Orange for medium battery
else
    COLOR="0xffff6b6b"  # Red for low battery
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹"
  ;;
  [6-8][0-9]) ICON="󰂀"
  ;;
  [3-5][0-9]) ICON="󰁽"
  ;;
  [1-2][0-9]) ICON="󰁻"
  ;;
  *) ICON="󰂎"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
  COLOR="0xff4fc3f7"  # Blue when charging
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "${NAME:-battery}" icon="$ICON" label="${PERCENTAGE}%" icon.color="$COLOR"