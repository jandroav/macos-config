#!/bin/bash
# =============================================================================
# update_workspaces.sh — Full refresh of all workspace indicator visibility
# =============================================================================
# Runs on every workspace change as a safety net. Scans ALL monitors and
# workspaces to ensure drawing=on/off is correct everywhere.
#
# This catches edge cases that space_windows.sh might miss (e.g., windows
# closed via cmd-q without triggering a workspace change, or windows that
# moved between workspaces in unexpected ways).
# =============================================================================

# Build two associative arrays: workspaces that should be shown vs hidden
declare -A changes_on changes_off

for mid in $(aerospace list-monitors); do
  # Non-empty workspaces on this monitor → should be visible
  for sid in $(aerospace list-workspaces --monitor "$mid" --empty no); do
    changes_on["$sid"]=1
  done
  # Empty workspaces on this monitor → should be hidden
  for sid in $(aerospace list-workspaces --monitor "$mid" --empty); do
    changes_off["$sid"]=1
  done
done

# The focused workspace is always shown, even if empty (so you can see where
# you are). Override it from the "off" list if it ended up there.
if [ -n "$FOCUSED_WORKSPACE" ]; then
  changes_on["$FOCUSED_WORKSPACE"]=1
  unset changes_off["$FOCUSED_WORKSPACE"]
  sketchybar --set space.$FOCUSED_WORKSPACE icon.highlight=on
fi

# Apply "off" changes first (skip any workspace that's also in the "on" list)
for sid in "${!changes_off[@]}"; do
  if [ -z "${changes_on[$sid]}" ]; then
    sketchybar --set space.$sid drawing=off
  fi
done

# Apply "on" changes
for sid in "${!changes_on[@]}"; do
  sketchybar --set space.$sid drawing=on
done
