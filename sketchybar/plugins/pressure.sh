#!/usr/bin/env sh
# =============================================================================
# pressure.sh — System thermal pressure level
# =============================================================================
# Uses macos-temp-tool with the -p flag to report the system's thermal
# pressure state: Nominal, Moderate, Heavy, Critical, or Trapping.
#
# "Nominal" = cool and happy. Anything else means the system is throttling
# CPU/GPU performance to manage heat.
# =============================================================================

thermal_pressure=$("$CONFIG_DIR/plugins/macos-temp-tool" -p | awk '{print $NF}')
LABEL="${thermal_pressure}"

sketchybar --set "$NAME" label="$LABEL"
