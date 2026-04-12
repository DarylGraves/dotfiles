#!/usr/bin/env bash

MODE="$1"

if [ "$MODE" = "h" ]; then
    i3-msg split h > /dev/null
    echo "H" > /tmp/i3_split_mode
else
    i3-msg split v > /dev/null
    echo "V" > /tmp/i3_split_mode
fi

# Trigger i3blocks update instantly
pkill -RTMIN+10 i3blocks
