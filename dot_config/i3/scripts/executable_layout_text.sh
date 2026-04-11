#!/bin/bash
layout=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true).layout')

if [ "$layout" == "splith" ]; then
    echo "Horizontal ↔"
elif [ "$layout" == "splitv" ]; then
    echo "Vertical ↕"
else
    echo "$layout"
fi
