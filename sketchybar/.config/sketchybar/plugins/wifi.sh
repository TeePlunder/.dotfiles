#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"
CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="Disconnected" icon=$WIFI_DISCONNECTED
else
  sketchybar --set $NAME label="$SSID (${CURR_TX}Mbps)" icon=$WIFI_CONNECTED
fi

sketchybar --add item wifi right                         \
           --set wifi    script="wifi.sh"                \
                         background.padding_right=10     \
                         update_freq=5

