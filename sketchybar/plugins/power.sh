#!/usr/bin/env sh
# =============================================================================
# power.sh — Battery percentage and charging indicator
# =============================================================================
# Updates the power_logo icon to show a battery level glyph (empty to full),
# or a charging icon when connected to AC power.
# Shows the percentage as a label on the battery item.
# =============================================================================

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

# On desktops or when battery info isn't available, exit silently
if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Update battery percentage label (icon is set statically in sketchybarrc)
sketchybar --set battery label="${PERCENTAGE}%"
