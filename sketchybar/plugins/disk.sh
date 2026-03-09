#!/usr/bin/env sh
# =============================================================================
# disk.sh — Root volume disk usage
# =============================================================================
# Shows "Used/Total" for the root filesystem (e.g., "187G/460G").
# Strips the trailing 'i' from macOS df output (e.g., "187Gi" → "187G").
# =============================================================================

DISK_INFO=$(df -h / | tail -1)
USED=$(echo "$DISK_INFO" | awk '{print $3}')
TOTAL=$(echo "$DISK_INFO" | awk '{print $2}')

USED=$(echo "$USED" | sed 's/i$//')
TOTAL=$(echo "$TOTAL" | sed 's/i$//')

sketchybar --set "$NAME" label="${USED}/${TOTAL}"
