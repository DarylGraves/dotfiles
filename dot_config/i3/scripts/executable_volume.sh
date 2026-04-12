#!/bin/bash
# Get volume and mute status
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -n 1)
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$MUTE" = "yes" ]; then
    echo "󰝟 Muted"
else
    echo "󰕾 ${VOL}%"
fi
