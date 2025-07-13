#!/bin/bash

# Get memory stats using vm_stat
MEMORY_STATS=$(vm_stat)

# Extract page size (usually 4096 bytes)
PAGE_SIZE=$(vm_stat | head -1 | grep -o '[0-9]\+')

# Extract memory values (in pages)
FREE_PAGES=$(echo "$MEMORY_STATS" | grep "Pages free" | grep -o '[0-9]\+')
INACTIVE_PAGES=$(echo "$MEMORY_STATS" | grep "Pages inactive" | grep -o '[0-9]\+')
SPECULATIVE_PAGES=$(echo "$MEMORY_STATS" | grep "Pages speculative" | grep -o '[0-9]\+')
WIRED_PAGES=$(echo "$MEMORY_STATS" | grep "Pages wired down" | grep -o '[0-9]\+')
ACTIVE_PAGES=$(echo "$MEMORY_STATS" | grep "Pages active" | grep -o '[0-9]\+')
COMPRESSED_PAGES=$(echo "$MEMORY_STATS" | grep "Pages stored in compressor" | grep -o '[0-9]\+')

# Calculate memory in GB
FREE_GB=$(echo "scale=1; ($FREE_PAGES + $INACTIVE_PAGES + $SPECULATIVE_PAGES) * $PAGE_SIZE / 1024 / 1024 / 1024" | bc)
USED_GB=$(echo "scale=1; ($WIRED_PAGES + $ACTIVE_PAGES + $COMPRESSED_PAGES) * $PAGE_SIZE / 1024 / 1024 / 1024" | bc)
TOTAL_GB=$(echo "scale=1; $FREE_GB + $USED_GB" | bc)

# Calculate usage percentage
USAGE_PERCENT=$(echo "scale=0; $USED_GB * 100 / $TOTAL_GB" | bc)

# Set color based on usage
if (( $(echo "$USAGE_PERCENT > 80" | bc -l) )); then
    COLOR="0xffff6b6b"  # Red for high usage
elif (( $(echo "$USAGE_PERCENT > 60" | bc -l) )); then
    COLOR="0xffffab00"  # Orange for medium usage
else
    COLOR="0xff51d88a"  # Green for low usage
fi

# Update the item
sketchybar --set memory \
    icon="󰍛" \
    label="${USED_GB}G/${TOTAL_GB}G" \
    icon.color="$COLOR"