#!/usr/bin/env bash
# =============================================================================
# aerospace.sh — Highlight the focused workspace indicator
# =============================================================================
# Called for each workspace item whenever aerospace_workspace_change fires.
# $1 is the workspace ID this item represents.
# $FOCUSED_WORKSPACE is the workspace that just received focus.
# $NAME is the sketchybar item name (e.g., "space.3").
#
# If this item's workspace matches the focused one, highlight it (pink accent).
# Otherwise, remove the highlight.
# =============================================================================

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.highlight=on
else
    sketchybar --set $NAME icon.highlight=off
fi
