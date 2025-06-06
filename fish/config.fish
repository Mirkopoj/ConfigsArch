if status is-interactive
	~/.config/fish/fetch.fish
end

set -gx GPG_TTY (tty)
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TERMINAL alacritty
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx AWT_TOOLKIT MToolkit
set -gx JDK_JAVA_OPTIONS '-Dsun.java2d.opengl=true'
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'
set -gx DEBUGINFOD_URLS 'https://debuginfod.archlinux.org'
set -gx ANDROID_SDK_ROOT '/opt/android-sdk'
set -gx GTK_THEME 'Adwaita:dark'

set -gx LIBCLANG_PATH '/home/mirko/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-18.1.2_20240912/esp-clang/lib'
if not contains "/home/mirko/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin" $PATH
	set -gx PATH '/home/mirko/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin' $PATH
end

#ALIASES

alias log "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias la "exa --group-directories-first -a"
alias ls "exa --group-directories-first"
alias ll "exa --group-directories-first -l -g -h"
alias lc "exa | grep -E '\.(c|h|cpp|rs|py|cu|s)\$'"
alias tree "exa --tree"
alias cat "bat"
alias vi "nvim"
alias update "paru -Sy --noconfirm archlinux-keyring; paru -Syu --sudoloop --noconfirm"
alias pip "pipx"
alias clang "/usr/bin/clang"
alias paru "paru --bottomup"
alias ip "ip -c"
alias startx "startx &> /dev/null"

alias sshOn "sudo systemctl start sshd"
alias sshOff "sudo systemctl stop sshd"

alias server "java -Xmx2G -Xms2G -jar server.jar nogui"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/usr/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX '~/.config/mamba'
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<

alias conda micromamba

zoxide init fish --cmd cd | source
