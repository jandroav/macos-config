#!/bin/bash

CPU=$(top -l 2 -n 0 -s 1 | grep "CPU usage" | tail -1 | sed 's/[%,]//g' | awk '{printf "%d", $3+$5}')

sketchybar --set cpu icon=􀫥 label="${CPU:-0}%"
