#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$WHITE
BATTERY_STATUS="BATTERY_"

if [[ $CHARGING != "" ]]; then
  BATTERY_STATUS="${BATTERY_STATUS}CHARGING_"
fi
case ${PERCENTAGE} in
100)
  ICON="${BATTERY_STATUS}100"
  COLOR=$GREEN
  ;;
9[0-9])
  ICON="${BATTERY_STATUS}90"
  COLOR=$GREEN
  ;;
8[0-9])
  ICON="${BATTERY_STATUS}80"
  COLOR=$GREEN
  ;;
7[0-9])
  ICON="${BATTERY_STATUS}70"
  COLOR=$GREEN
  ;;
6[0-9])
  ICON="${BATTERY_STATUS}60"
  COLOR=$GREEN
  ;;
5[0-9])
  ICON="${BATTERY_STATUS}50"
  COLOR=$GREEN
  ;;
4[0-9])
  ICON="${BATTERY_STATUS}40"
  COLOR=$GREEN
  ;;
3[0-9])
  ICON="${BATTERY_STATUS}30"
  COLOR=$GREEN
  ;;
2[0-9])
  ICON="${BATTERY_STATUS}20"
  COLOR=$GREEN
  ;;
1[0-9])
  ICON="${BATTERY_STATUS}10"
  COLOR=$GREEN
  ;;
esac

sketchybar --set "$NAME" drawing=$DRAWING icon="${!ICON}" icon.color="$COLOR" label="$PERCENTAGE"
