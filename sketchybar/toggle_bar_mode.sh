#!/bin/bash
# =============================================================================
# toggle_bar_mode.sh — Switch between normal and compact bar modes
# =============================================================================
# Reads the current mode from .bar_mode, flips it, writes the new mode,
# and reloads sketchybar. The reload re-runs sketchybarrc, which reads
# the mode file and adjusts bar height, font sizes, padding, and the
# AeroSpace top gap accordingly.
#
# Triggered by clicking the chevron divider (space_divider) in the bar.
# =============================================================================

MODE_FILE="$HOME/.config/sketchybar/.bar_mode"

CURRENT_MODE=$(<"$MODE_FILE")

if [ "$CURRENT_MODE" = "compact" ]; then
    NEW_MODE="normal"
else
    NEW_MODE="compact"
fi

echo "$NEW_MODE" > "$MODE_FILE"

sketchybar --reload
