#!/usr/bin/env sh
# =============================================================================
# cpu_ram.sh — CPU usage percentage and RAM consumption
# =============================================================================
# CPU: sums %cpu across all processes, divides by core count for a 0-100% value.
# RAM: reads active + wired + compressed pages from vm_stat, converts to GB.
# Output: "12% 8.3G"
# =============================================================================

# Sum all per-process CPU percentages and normalize by number of CPU cores
CPU=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f", s}')
NCPU=$(sysctl -n hw.ncpu)
CPU_PCT=$((CPU / NCPU))

# Calculate used RAM from vm_stat page counts
# Active: pages recently used
# Wired: pages locked in memory by the kernel
# Compressed: pages the system has compressed to save physical RAM
RAM_PAGES=$(vm_stat | awk '
  /Pages active/     { active = $NF+0 }
  /Pages wired/      { wired = $NF+0 }
  /Pages occupied by compressor/ { compressed = $NF+0 }
  END { print active + wired + compressed }
')
# Convert pages (4096 bytes each) to gigabytes
RAM_GB=$(echo "$RAM_PAGES" | awk '{ printf "%.1f", $1 * 4096 / 1073741824 }')

sketchybar --set "$NAME" label="${CPU_PCT}% ${RAM_GB}G"
