if test -z "$VIMRUNTIME"
	if test $TERM = "linux"
		neofetch
	else 
		neofetch --ascii_colors 14 37 --colors 14 7 7 14 7 7 --bar_colors 7 14
	end
end

set -gx GPG_TTY (tty)
set -gx EDITOR nvim

#ALIASES

alias log "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias la "exa --group-directories-first -a"
alias ls "exa --group-directories-first"
alias lc "exa | egrep '\.(c|h|cpp|rs|py|cu|s)\$'"
alias sshOn "sudo systemctl start sshd"
alias sshOff "sudo systemctl stop sshd"
