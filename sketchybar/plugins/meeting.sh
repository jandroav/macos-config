#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

URL_CACHE="/tmp/sketchybar_meeting_url"

DATA=$(icalBuddy -df "%Y-%m-%d" -tf "%H:%M" -nrd -nc -ea \
  -eep "attendees" eventsToday+1 2>/dev/null)

if [ -z "$DATA" ]; then
  sketchybar --set meeting drawing=off
  rm -f "$URL_CACHE"
  exit 0
fi

RESULT=$(ICALBUDDY_DATA="$DATA" /usr/bin/env python3 <<'PYEOF'
import os
import re
import time

NOW = time.time()
data = os.environ.get("ICALBUDDY_DATA", "")

events = []
current = None
for line in data.splitlines():
    if not line.strip():
        continue
    if not line[0].isspace():
        if current:
            events.append(current)
        title = line.strip()
        # strip leading bullet/icalBuddy markers
        title = re.sub(r"^[•*\-•]\s*", "", title)
        current = {"title": title, "url": None, "start": None, "end": None}
    else:
        m = re.search(r"(\d{4}-\d{2}-\d{2})\s+at\s+(\d+:\d+)\s+-\s+(\d+:\d+)", line)
        if m and current is not None:
            d, s, e = m.groups()
            try:
                current["start"] = time.mktime(time.strptime(f"{d} {s}", "%Y-%m-%d %H:%M"))
                current["end"]   = time.mktime(time.strptime(f"{d} {e}", "%Y-%m-%d %H:%M"))
            except Exception:
                pass
        url_m = re.search(r"https?://\S+", line)
        if url_m and current is not None and not current["url"]:
            current["url"] = url_m.group(0).rstrip(",.;")

if current:
    events.append(current)

target = next((e for e in events if e["end"] and e["end"] > NOW), None)
if not target:
    raise SystemExit(0)

title = target["title"]
if len(title) > 30:
    title = title[:27] + "..."

delta = (target["start"] or NOW) - NOW
if delta <= 0:
    time_label = "now"
else:
    h = int(delta // 3600)
    m = int((delta % 3600) // 60)
    time_label = f"in {h}h {m}m" if h else f"in {m}m"

print(f"{title}\t{time_label}\t{target['url'] or ''}")
PYEOF
)

if [ -z "$RESULT" ]; then
  sketchybar --set meeting drawing=off
  rm -f "$URL_CACHE"
  exit 0
fi

IFS=$'\t' read -r TITLE TIME_LABEL URL <<< "$RESULT"

if [ -n "$URL" ]; then
  echo "$URL" > "$URL_CACHE"
else
  rm -f "$URL_CACHE"
fi

sketchybar --set meeting drawing=on icon=􀉉 label="$TITLE $TIME_LABEL"
