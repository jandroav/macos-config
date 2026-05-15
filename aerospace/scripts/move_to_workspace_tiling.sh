#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  exit 64
fi

workspace="$1"

aerospace move-node-to-workspace "$workspace" --focus-follows-window

while IFS= read -r window_id; do
  [[ -n "$window_id" ]] || continue
  aerospace layout --window-id "$window_id" tiling >/dev/null 2>&1 || true
done < <(aerospace list-windows --workspace "$workspace" --format '%{window-id}')

aerospace flatten-workspace-tree --workspace "$workspace" >/dev/null 2>&1 || true
aerospace balance-sizes --workspace "$workspace" >/dev/null 2>&1 || true
