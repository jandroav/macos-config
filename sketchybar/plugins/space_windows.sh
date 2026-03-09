#!/bin/bash
# =============================================================================
# space_windows.sh — Show/hide workspace indicators based on window state
# =============================================================================
# This plugin runs whenever:
#   - You switch workspaces (aerospace_workspace_change)
#   - You switch apps (front_app_switched)
#   - A workspace moves to another monitor (aerospace_monitor_change)
#
# Its job: only show workspace indicators for workspaces that have windows,
# plus always show the currently focused workspace.
#
# Environment variables (set by sketchybar event triggers):
#   $SENDER            — which event triggered this script
#   $FOCUSED_WORKSPACE — the workspace that just got focus
#   $PREV_WORKSPACE    — the workspace we just left
#   $TARGET_MONITOR    — (monitor change only) the monitor ID to display on
# =============================================================================

# -- Monitor change: no display reassignment needed (indicators show on all monitors)
if [ "$SENDER" = "aerospace_monitor_change" ]; then
  exit 0
fi

# -- Workspace change: show/hide the previous workspace indicator -------------
if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # Check if the workspace we just left still has any windows
  prevapps=$(aerospace list-windows --workspace "$PREV_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  if [ "${prevapps}" != "" ]; then
    # Still has windows — keep its indicator visible
    sketchybar --set space.$PREV_WORKSPACE drawing=on
  else
    # Empty workspace — hide its indicator from the bar
    sketchybar --set space.$PREV_WORKSPACE drawing=off
  fi
else
  # For non-workspace-change events (e.g., front_app_switched), we don't have
  # $FOCUSED_WORKSPACE from the event, so query AeroSpace directly.
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
fi

# Always show the currently focused workspace indicator
sketchybar --set space.$FOCUSED_WORKSPACE drawing=on
