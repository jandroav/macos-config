#!/usr/bin/env sh
# =============================================================================
# net.sh — Wi-Fi network name
# =============================================================================
# Shows the current Wi-Fi SSID, truncated for readability:
# - If the first word is >10 chars: show first 7 chars + "..."
# - If shorter: show first word + first 2 chars of second word + "..."
# - If disconnected: show "N/A" with dimmed styling
#
# Changes the net_logo background color to indicate connection state:
# - Connected: pink background (0xfff2cdcd)
# - Disconnected: dark background (0xff3C3E4F)
# =============================================================================

CURRENT_NETWORK=$(networksetup -getairportnetwork en0 2>/dev/null | sed 's/Current Wi-Fi Network: //')

if [ -z "$CURRENT_NETWORK" ] || echo "$CURRENT_NETWORK" | grep -q "You are not associated with an AirPort network"; then
    LABEL="N/A"
    sketchybar --set net_logo background.color=0xff3C3E4F --set net label.color=0xff1e1d2e
else
    sketchybar --set net_logo background.color=0xfff2cdcd --set net label.color=0xffECEFF4

    # Truncate long network names to fit the bar
    if [ "$(echo "$CURRENT_NETWORK" | awk '{ print length($1) }')" -gt 10 ]; then
        label=$(echo "$CURRENT_NETWORK" | awk '{ print substr($0, 1, 7) }')
        label=$(echo "$label" | sed 's/ *$//')
        LABEL="$label"...
    else
        LABEL=$(echo "$CURRENT_NETWORK" | awk '{ printf "%s", $1 }')
        if [ "$(echo "$CURRENT_NETWORK" | awk '{ print NF }')" -gt 1 ]; then
            SECOND_WORD=$(echo "$CURRENT_NETWORK" | awk '{ printf "%s", substr($2, 1, 2) }')
            LABEL="$LABEL $SECOND_WORD..."
        fi
    fi
fi

sketchybar --set "$NAME" label="$LABEL"
