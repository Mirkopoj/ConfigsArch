if test -z "$VIMRUNTIME" && test -z "$PS1" && test -z "$SSH_CLIENT" && test -z "$SSH_TTY"
	if test $TERM = "linux"
		neofetch
	else 
		neofetch --ascii_colors 14 37 --colors 14 7 7 14 7 7 --bar_colors 7 14
	end
end

set -gx GPG_TTY (tty)
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx AWT_TOOLKIT MToolkit
set -gx JDK_JAVA_OPTIONS '-Dsun.java2d.opengl=true'
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'

#ALIASES

alias log "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias la "exa --group-directories-first -a"
alias ls "exa --group-directories-first"
alias lc "exa | egrep '\.(c|h|cpp|rs|py|cu|s)\$'"

alias sshOn "sudo systemctl start sshd"
alias sshOff "sudo systemctl stop sshd"

alias server "java -Xmx2G -Xms2G -jar server.jar nogui"
