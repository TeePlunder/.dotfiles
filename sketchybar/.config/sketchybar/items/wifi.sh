#!/bin/bash

wifi=(
    script="$PLUGIN_DIR/wifi.sh"
    background.padding_right=10
    update_freq=5
)

sketchybar --add item wifi right                         \
           --set wifi "${wifi[@]}"