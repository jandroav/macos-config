#!/bin/bash

TOTAL_BYTES=$(sysctl -n hw.memsize)
PAGE_SIZE=$(vm_stat | head -1 | awk -F'[() ]+' '{for (i=1;i<=NF;i++) if ($i+0>0) { print $i; exit } }')

USED_PAGES=$(vm_stat | awk '
  /Pages active|Pages wired down|Pages occupied by compressor/ {
    v = $NF
    gsub(/\./, "", v)
    sum += v
  }
  END { print sum+0 }
')

if [ -z "$PAGE_SIZE" ] || [ -z "$TOTAL_BYTES" ] || [ "$TOTAL_BYTES" -eq 0 ]; then
  PCT=0
else
  USED_BYTES=$((USED_PAGES * PAGE_SIZE))
  PCT=$((USED_BYTES * 100 / TOTAL_BYTES))
fi

sketchybar --set mem icon=􀫦 label="${PCT}%"
