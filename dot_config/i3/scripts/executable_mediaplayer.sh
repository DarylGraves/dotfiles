#!/bin/bash
# Get the artist and title from the active player
metadata=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)

if [ -n "$metadata" ]; then
    # Truncate if too long (e.g., 40 chars)
    echo "${metadata:0:40}"
else
    echo "No Media"
fi
