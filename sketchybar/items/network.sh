#!/bin/bash

network=(
    script="$PLUGIN_DIR/network.sh"
    background.padding_right=10
    update_freq=5
    label.drawing=off
)

sketchybar --add item network right \
    --set network "${network[@]}" \
    --subscribe network mouse.entered mouse.exited
