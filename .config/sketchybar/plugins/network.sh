#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

## NEW WITH ETHERNET ##
setWifi() {
  CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
  SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"

  if [ "$SSID" = "" ]; then
    sketchybar --set $NAME label="No Wifi" icon=$WIFI_DISCONNECTED
  else
    sketchybar --set $NAME label="$SSID" icon=$WIFI_CONNECTED
  fi
}

setEthernet() {
  sketchybar --set $NAME label="" icon=$ETHERNET
}

INTERFACE=$(route get example.com | grep interface | grep -o "en[0-9]\+")

case $INTERFACE in
"en7")
  setEthernet
  ;;
"en0") setWifi ;;
esac

case $SENDER in
"mouse.entered") sketchybar --set $NAME label.drawing=on ;;
"mouse.exited") sketchybar --set $NAME label.drawing=off ;;
esac
