#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"
CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="No Wifi" icon=$WIFI_DISCONNECTED
else
  sketchybar --set $NAME label="$SSID" icon=$WIFI_CONNECTED
fi
