#! /bin/sh

LEVEL="$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}' | sed 's/\%//g')"

if [ $LEVEL -le 100 ]; then
	rofi_theme="34%;"
else
	rofi_theme="31%;"
fi
chosen=$(printf "  Power Off\n  Restart\n  Lock" | rofi -dmenu -i -theme-str '@import "power.rasi"' -theme-str "window { width: "$rofi_theme" }")

case "$chosen" in
	"  Power Off") shutdown now ;;
	"  Restart") reboot ;;
	"  Lock") betterlockscreen -l dimblur --blur 0.1 --display 1 --span ;;
	*) exit 1 ;;
esac
