# Luke's config for the Zoomer Shell

# Justin path for Dotnet SDK 
export PATH=$PATH:$HOME/dotnet

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# justin aliases here:

alias cf="xsel -b "
alias zz="pwd | xclip -rmlastnl -sel c"
alias csc="colorscript -r"
alias mk="g++ -o "
alias kk="rm nohup.out"
alias k="bash /home/justin/detach.sh "
alias mkj="javac -d . "
alias rmr="rm -r"
alias etcher=" ./Documents/syslogs/balenaEtcher-1.7.7-x64.AppImage"
alias compress="tar -pczf "
alias add="~/build/staging-area/append-file "
alias mk="g++ -o "
alias gn="bash /home/justin/detach.sh geany "
alias mp3="youtube-dl --extract-audio --audio-format mp3 "
alias read="koreader "
alias size="sudo du -sh " 
alias mm="neofetch | grep Memory"
alias pp="python3"
alias sip="bash /home/justin/build/get-IP-address/display-ip.sh"
alias nee="pfetch"
alias ss="cd /home/justin/Documents/USM/Spring-22"
#alias mk="bash /home/justin/build/auto-project.sh"
alias eees="bash ./eees.sh" 
alias rc="openbox --reconfigure"
alias sw="ssh pi@192.168.1.220 -Y"
alias scc="java solve `xrandr --verbose | awk '/ connected /{}/Brightness:/{print $2}'` `xrandr | grep -w connected  | awk -F'[ ]' '{print $1}'`"
alias F="nautilus "
alias ff="cd Documents/USM/Spring-22"
alias FF="bash /home/justin/favorites-directory.sh"
alias prt="xfce4-panel -q"
alias pst="xfce4-panel "
alias se="python3 Desktop/automation/sendmessage.py Desktop/automation/filemsg "
# alias se="ls * "
alias btop="bpytop"
alias bt="acpi -V"
alias fd="fdfind -H"
alias c="clear"
alias neo="neofetch"
alias l="ls"
alias h="ls -a"
alias hm="cd /home/justin"
alias x="exit"
alias disk="baobab"
alias vm="cat /proc/sys/vm/swappiness"
alias f="nano"
alias b="cd .."
alias d="cd"
alias tp="sensors | grep Tctl"
#alias tp="watch -n 2 sensors"
#alias tp="cat /sys/class/thermal/thermal_zone0/temp"
alias minecraft="/opt/minecraft-launcher/minecraft-launcher"
alias unity="./Desktop/UnityHub.AppImage"
alias pdf="nohup evince"
alias jot="gedit "Desktop/automation/novembertodos" "Desktop/automation/words""
alias sc="xrandr --output 0x1c1 --brightness"
alias jot="gedit "Desktop/automation/novembertodos" "Desktop/automation/words""
alias gcube="dolphin-emu"
alias www="w3m"
alias img="eog "
#alias pdf="evince %U"
#alias pdf="libreoffice --draw %U"
alias hs="history"
alias n64="mupen64plus --gfx /usr/lib/x86_64-linux-gnu/mupen64plus/mupen64plus-video-glide64mk2.so"
alias del="rm -r -v"
alias note="gedit" 
alias doc="libreoffice --writer"
alias bb="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage"
alias upgrade='sudo apt-get upgrade -y && sudo apt upgrade'
alias update='sudo apt-get update -y && sudo apt update'
alias tux="etr"
alias eclipse="sudo /opt/eclipse/eclipse"
alias xf="xfce4-terminal"
alias t="terminator"
alias logout="xfce4-session-logout"
alias sl="xrandr --verbose | awk '/ connected /{}/Brightness:/{print $2}'"
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# justin colorscript on terminal launch:
#colorscript random

# Keep at Bottom
export DOTNET_ROOT=$HOME/dotnet
