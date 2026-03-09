#!/usr/bin/env sh
# =============================================================================
# window_title.sh — Display the focused app's name in the bar
# =============================================================================
# Triggered by front_app_switched. $INFO contains the name of the app that
# just received focus (e.g., "Safari", "Terminal").
# =============================================================================

sketchybar --set $NAME label="$INFO"
