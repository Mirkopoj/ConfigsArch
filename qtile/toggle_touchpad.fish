#!/bin/fish
set touchpad_state (xinput list-props SYNA3602:00\ 0911:5288\ Touchpad | grep Device\ Enabled)
if string match '*1' $touchpad_state
	xinput disable SYNA3602:00\ 0911:5288\ Touchpad;
else
	xinput enable SYNA3602:00\ 0911:5288\ Touchpad;
end
