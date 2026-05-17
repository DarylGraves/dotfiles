#!/bin/bash

# Define target hardware naming and target display output
TARGET_NAME="wch.cn TouchScreen"
TARGET_OUTPUT="HDMI-1"
STATE_FILE="/tmp/last_focused_window"

# 1. Hardware Verification Check
# Dynamically find the active ID instead of hardcoding 12
TOUCH_ID=$(xinput list | grep "$TARGET_NAME" | grep -o 'id=[0-9]\+' | grep -o '[0-9]\+' | tail -n 1)
OUTPUT_EXISTS=$(xrandr --query | grep "^$TARGET_OUTPUT connected")

# Exit cleanly if the touchscreen or the monitor is missing
if [ -z "$TOUCH_ID" ] || [ -z "$OUTPUT_EXISTS" ]; then
    exit 0
fi

# 2. Clean up existing tracking loops safely
pkill -f "xinput test $TOUCH_ID" 2>/dev/null
pkill -f "touch-snapback-tracker" 2>/dev/null
pgrep -f "touch-snapback.sh" | grep -v "$$" | xargs kill 2>/dev/null

# 3. Map screen bounds to the target output
xinput map-to-output "$TOUCH_ID" "$TARGET_OUTPUT" 2>/dev/null

# 4. High-speed tracker (Checks focus every 20ms)
# Only writes the raw window ID to minimize I/O overhead
(
    exec -a touch-snapback-tracker bash -c "
    while true; do
        xdotool getwindowfocus > '$STATE_FILE' 2>/dev/null
        sleep 0.02
    done
    "
) &

# 5. Debounced Focus Correction Loop
LAST_TOUCH=0

stdbuf -oL xinput test "$TOUCH_ID" | while read -r line; do
    if [[ "$line" == *"motion"* ]]; then
        CURRENT_TIME=$(date +%s%3N)
        TIME_DIFF=$((CURRENT_TIME - LAST_TOUCH))

        if [ $TIME_DIFF -gt 200 ]; then
            if [ -f "$STATE_FILE" ]; then
                TARGET_WINDOW=$(cat "$STATE_FILE")

                (
                    # Give X11 a 100ms window to process the remote touch click
                    sleep 0.10
                    # Return focus to the original active window frame
                    i3-msg "[id=\"$TARGET_WINDOW\"] focus" >/dev/null 2>&1
                ) &
            fi
        fi
        LAST_TOUCH=$CURRENT_TIME
    fi
done
