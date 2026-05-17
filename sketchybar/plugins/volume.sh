#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# This script handles volume updates and slider interactions.

# Returns 0 if current output is headphones / external (not built-in speakers)
is_headphones() {
  local out
  out=$(SwitchAudioSource -c 2>/dev/null)
  [ -z "$out" ] && return 1
  case "$out" in
    *"MacBook"*|*"Built-in"*|*"Internal"*|*"Speakers"*)
      return 1
      ;;
    *)
      return 0
      ;;
  esac
}

# Pick icon based on volume level AND output device
pick_icon() {
  local vol="$1"
  if is_headphones; then
    if [ "$vol" -eq "0" ]; then
      echo "􀑈"   # headphones (muted — same glyph; system has no slashed variant)
    else
      echo "􀑈"   # headphones
    fi
    return
  fi
  if [ "$vol" -eq "0" ]; then
    echo "􀊣"
  elif (( vol > 0 && vol <= 29 )); then
    echo "􀊥"
  elif (( vol >= 30 && vol <= 69 )); then
    echo "􀊧"
  else
    echo "􀊩"
  fi
}

volume_change() {
  ICON=$(pick_icon "$INFO")
  sketchybar --set volume_icon label="$INFO%" icon="$ICON" \
             --set volume_slider slider.percentage=$INFO
}

show_popup() {
  sketchybar --set volume_icon popup.drawing=on
  sleep 2
  FINAL_PERCENTAGE=$(sketchybar --query volume_slider | jq -r ".slider.percentage")
  if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
    sketchybar --set volume_icon popup.drawing=off
  fi
}

mouse_clicked() {
  local popup_drawing
  popup_drawing=$(sketchybar --query volume_icon | jq -r ".popup.drawing")
  if [ "$popup_drawing" = "on" ]; then
    sketchybar --set volume_icon popup.drawing=off \
               --set volume_slider slider.knob.drawing=off
  else
    show_popup
    sketchybar --set volume_slider slider.knob.drawing=on
  fi
}

monitor_slider_drag() {
  local last_percentage=-1
  local idle_count=0

  while true; do
    local current_percentage=$(sketchybar --query volume_slider 2>/dev/null | jq -r ".slider.percentage" 2>/dev/null)

    if [ -z "$current_percentage" ] || [ "$current_percentage" = "null" ]; then
      sleep 0.2
      continue
    fi

    if [ "$current_percentage" != "$last_percentage" ]; then
      local int_percentage=$(printf "%.0f" "$current_percentage")

      if (( int_percentage < 0 )); then
        int_percentage=0
      elif (( int_percentage > 100 )); then
        int_percentage=100
      fi

      osascript -e "set volume output volume $int_percentage" 2>/dev/null

      ICON=$(pick_icon "$int_percentage")
      sketchybar --set volume_icon label="$int_percentage%" icon="$ICON" 2>/dev/null
      last_percentage=$current_percentage
      idle_count=0
    else
      ((idle_count++))
      if [ $idle_count -gt 3 ]; then
        sleep 0.3
      else
        sleep 0.1
      fi
      continue
    fi

    sleep 0.1
  done
}

case "$SENDER" in
  "mouse.clicked")
    if [ "$NAME" = "volume_slider" ]; then
      if [ -n "$PERCENTAGE" ]; then
        PERCENTAGE=$(printf "%.0f" "$PERCENTAGE")
        if (( PERCENTAGE < 0 )); then
          PERCENTAGE=0
        elif (( PERCENTAGE > 100 )); then
          PERCENTAGE=100
        fi
        osascript -e "set volume output volume $PERCENTAGE"
        ICON=$(pick_icon "$PERCENTAGE")
        sketchybar --set volume_icon label="$PERCENTAGE%" icon="$ICON"
        show_popup
      fi
    elif [ "$NAME" = "volume_icon" ]; then
      mouse_clicked
    fi
  ;;
  "volume_change") volume_change
  ;;
  "mouse.entered")
    sketchybar --set volume_slider slider.knob.drawing=on
    monitor_slider_drag &
    echo $! > /tmp/sketchybar_volume_monitor.pid
  ;;
  "mouse.exited")
    sketchybar --set volume_slider slider.knob.drawing=off
    if [ -f /tmp/sketchybar_volume_monitor.pid ]; then
      kill $(cat /tmp/sketchybar_volume_monitor.pid) 2>/dev/null
      rm /tmp/sketchybar_volume_monitor.pid
    fi
  ;;
  *)
    # Periodic refresh — re-detect device + repaint icon
    CURRENT=$(osascript -e "output volume of (get volume settings)" 2>/dev/null)
    if [ -n "$CURRENT" ] && [ "$CURRENT" != "missing value" ]; then
      ICON=$(pick_icon "$CURRENT")
      sketchybar --set volume_icon label="${CURRENT}%" icon="$ICON"
    fi
  ;;
esac
