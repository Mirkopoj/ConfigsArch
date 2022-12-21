#! /bin/sh

chosen=$(printf "  Power Off\n  Restart\n  Lock" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
	"  Power Off") shutdown now ;;
	"  Restart") reboot ;;
	"  Lock") betterlockscreen -l dimblur --blur 0.1 --display 1 --span ;;
	*) exit 1 ;;
esac
