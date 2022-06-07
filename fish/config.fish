if test $TERM = "linux"
	neofetch
else
	neofetch --ascii_colors 14 37 --colors 14 7 7 14 7 7 --bar_colors 7 14
end

#ALIASES

alias log "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias ls "exa --group-directories-first"
alias lc "exa | egrep '\.(c|h|cpp|rs|py|cu)\$'"

#FUNCTIONS

function dispDup --wraps='xrandr --output HDMI2 --auto --noprimary' --description 'alias dispDup=xrandr --output HDMI2 --auto --noprimary'
  xrandr --output HDMI2 --auto --noprimary; 
  qtile cmd-obj -o cmd -f reload_config;
end

function dispExp --wraps='xrandr --output HDMI2 --auto --noprimary --left-of eDP1' --description 'alias dispExp=xrandr --output HDMI2 --auto --noprimary --left-of eDP1'
  xrandr --output HDMI2 --auto --noprimary --left-of eDP1 $argv; 
  qtile cmd-obj -o cmd -f reload_config;
end

function dispOff --wraps='--output HDMI2 --off' --wraps='xrandr --output HDMI2 --off' --description 'alias dispOff=xrandr --output HDMI2 --off'
  xrandr --output HDMI2 --off $argv; 
  qtile cmd-obj -o cmd -f reload_config;
end
