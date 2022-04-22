if status is-interactive
    # Commands to run in interactive sessions can go here
end
if test $TERM = "linux"
	neofetch
else
	neofetch --ascii_colors 14 37 --colors 14 7 7 14 7 7 --bar_colors 7 14
end
