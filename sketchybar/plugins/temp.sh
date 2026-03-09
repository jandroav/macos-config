#!/usr/bin/env sh
# =============================================================================
# temp.sh — Average CPU/SoC temperature
# =============================================================================
# Uses a custom macos-temp-tool binary (in the plugins directory) to read
# Apple Silicon thermal sensors matching the "PMU tdev" filter.
# Averages all matching sensor values and displays in Celsius.
# =============================================================================

filter="PMU tdev"
sensor_output=$("$CONFIG_DIR/plugins/macos-temp-tool" -f "${filter}" | awk '{val=$NF} val>=0{sum+=val; n++} END{if(n>0) printf "%.1f", sum/n; else print "N/A"}')
LABEL="${sensor_output}°C"

sketchybar --set "$NAME" label="$LABEL"
