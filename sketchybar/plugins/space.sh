#!/bin/sh

# --- AeroSpace version ---
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
WORKSPACE_NUM="${NAME##*.}"

if [ "$FOCUSED_WORKSPACE" = "$WORKSPACE_NUM" ]; then
  sketchybar --animate tanh 10 --set "$NAME" \
    background.drawing=on \
    background.color=0xffffc799 \
    label.color=0xaa1a1a1a \
    icon.color=0xaa1a1a1a
else
  sketchybar --animate tanh 10 --set "$NAME" \
    background.drawing=on \
    background.color=0xaa1a1a1a \
    label.color=0xffffc799 \
    icon.color=0xffffc799
fi
