#!/bin/bash

clear
echo "========================================="
echo "   FOCUS SNAPBACK SYSTEM DIAGNOSTICS     "
echo "========================================="

# 1. Clean up existing tracking loops
pkill -f "xinput test" 2>/dev/null
pkill -f "touch-snapback-tracker" 2>/dev/null
pgrep -f "touch-snapback.sh" | grep -v "$$" | xargs kill 2>/dev/null

# 2. Map screen bounds to HDMI-1
xinput map-to-output 11 HDMI-1 2>/dev/null
xinput map-to-output 12 HDMI-1 2>/dev/null

# 3. High-speed tracker
(
    exec -a touch-snapback-tracker bash -c '
    while true; do
        # Save both Window ID and Window Name for explicit logs
        W_ID=$(xdotool getwindowfocus 2>/dev/null)
        W_NAME=$(xdotool getwindowfocus getwindowname 2>/dev/null)
        echo "${W_ID}|${W_NAME}" > /tmp/last_focused_window
        sleep 0.02
    done
    '
) &

echo "[INFO] High-speed tracker active."
echo "[INFO] Monitoring ID 12 stream..."
echo "-----------------------------------------"

# 4. Instrumented Focus Correction Loop
LAST_TOUCH=0

stdbuf -oL xinput test 12 | while read -r line; do
    if [[ "$line" == *"motion"* ]]; then
        CURRENT_TIME=$(date +%s%3N)
        TIME_DIFF=$((CURRENT_TIME - LAST_TOUCH))

        if [ $TIME_DIFF -gt 200 ]; then
            echo "[EVENT] Distinct touch sequence detected!"
            
            if [ -f /tmp/last_focused_window ]; then
                RAW_DATA=$(cat /tmp/last_focused_window)
                TARGET_WINDOW=$(echo "$RAW_DATA" | cut -d'|' -f1)
                TARGET_NAME=$(echo "$RAW_DATA" | cut -d'|' -f2-)

                echo "        -> Target Window to Restore: $TARGET_NAME (ID: $TARGET_WINDOW)"

                (
                    sleep 0.10
                    # Check what stole the focus before executing restore
                    STOLEN_ID=$(xdotool getwindowfocus 2>/dev/null)
                    STOLEN_NAME=$(xdotool getwindowfocus getwindowname 2>/dev/null)
                    echo "        -> Current Focus Right Now : $STOLEN_NAME (ID: $STOLEN_ID)"
                    
                    echo "        -> Triggering i3 focus restore instruction..."
                    i3-msg "[id=\"$TARGET_WINDOW\"] focus"
                    echo "-----------------------------------------"
                ) &
            else
                echo "        -> [ERROR] Tracking state file missing from RAM!"
            fi
        fi
        LAST_TOUCH=$CURRENT_TIME
    fi
done
