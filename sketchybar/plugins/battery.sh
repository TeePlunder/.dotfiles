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
BATTERY_COLOR="BATTERY_COLOR_"

if [[ $CHARGING != "" ]]; then
  BATTERY_STATUS="${BATTERY_STATUS}CHARGING_"
fi
case ${PERCENTAGE} in
100)
  PERCENT_VALUE=100
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
9[0-9])
  PERCENT_VALUE=90
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
8[0-9])
  PERCENT_VALUE=80
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
7[0-9])
  PERCENT_VALUE=70
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
6[0-9])
  PERCENT_VALUE=60
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
5[0-9])
  PERCENT_VALUE=50
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
4[0-9])
  PERCENT_VALUE=40
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
3[0-9])
  PERCENT_VALUE=30
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
2[0-9])
  PERCENT_VALUE=20
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
1[0-9])
  PERCENT_VALUE=10
  ICON="${BATTERY_STATUS}${PERCENT_VALUE}"
  COLOR="${BATTERY_COLOR}${PERCENT_VALUE}"
  ;;
esac

sketchybar --set "$NAME" drawing=$DRAWING icon="${!ICON}" icon.color="${!COLOR}" label="$PERCENTAGE"
