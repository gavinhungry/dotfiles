[ -z "$PS1" ] && return
[ "$(id -un)" == "$(id -gn)" ] && umask 0002 || umask 0022

stty -echoctl

# --- ENVIRONMENT --------------------------------------------------------------
export PROMPT_COLOR=$(prompt-color)
export PS1='[\[\e[1;${PROMPT_COLOR}m\]\u@${HOSTNAME}\[\e[0m\]: \W]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/\~}\007"'

export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export GPG_TTY=$(tty)

# --- FUNCTIONS ----------------------------------------------------------------

aliased() { alias $1 | cut -d= -f2- | sed -r "s/(^'|'$)//g" ;}
cmd() { compgen -c | sort | grep --color "${1:-$^}" ;}
cw() { [ -f "$(type -p $1)" ] && cat "$(type -p $1)" || type "$1" 2> /dev/null ;}
dif() { diff --color=always "$@" | less ;}
dm() { findmnt -no SOURCE,TARGET,FSTYPE,OPTIONS -T ${1:-.} | column -t ;}
eman() {
  if [ -z "$*" ]; then man; return; fi
  man -w $* > /dev/null && \
  emacs --eval "(progn (man \"$*\") (kill-buffer-and-window) \
                (run-with-idle-timer 0 nil 'linum-mode 0))"
}
emi() { emacs --insert <("$@" 2>&1) ;}
ew() { [ -f "$(which $1)" ] && $EDITOR "$(which $1)" ;}
f() {
  DIR=$(
    fd -t d -H -E .git -E node_modules |\
    fzf -e --height=20 --keep-right --layout=reverse --prompt 'f> '
  )

  [ -n "$DIR" ] && cd "$DIR"
}
lw() { [ -f "$(which $1)" ] && ls -lh --color "$(which $1)" ;}
ow() { [ -f "$(which $1)" ] && open "$(which $1)" ;}
highlight() { grep --color -E "$1|$" "${@:2}" ;}
term() { exo-open --launch TerminalEmulator ${1:-.} ;}

# --- ALIASES ------------------------------------------------------------------

alias -- -='cd - > /dev/null'
alias ..='cd ..'
alias acme.sh='sudo acme.sh --home /etc/ssl/acme.sh'
alias alsamixer='alsamixer --view=all'
alias bakfiles='updatedb && locate -r "\~$\|#[^/]*#$" | grep -v /node_modules/ | esc'
alias bc='bc --quiet'
alias bd='. bd -s &> /dev/null'
alias cls='tput reset'
alias clx='history -c; cls'
alias dc='cd'
alias dd='dd status=progress'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -Th'
alias diff='diff --color'
alias dt='df -t $(\df --output=fstype / | sed 1d)'
alias dmesg='sudo dmesg -w'
alias du='du -h -d1'
alias edid='sudo get-edid | edid-decode'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias esc='xargs -I {} sh -c '\''printf %q "{}" && echo'\'''
alias exifstrip='exiftool -all='
alias ffmpeg='ffpb'
alias fmount='fusermount'
alias fumount='fmount -u'
alias free='free -h'
alias gh='github'
alias gpge='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='GREP_USE_SPACE_SEPARATOR=1 grep --color'
alias htop='htop -U -d5'
alias ignoreeof='set -o ignoreeof'
alias iotop='sudo iotop -o'
alias iodev='iostat -dym 1 1'
alias iowatch='S_COLORS=always watch -n0 $(aliased iodev)'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias kurl='curl --ntlm --negotiate -u :'
alias la='ls -d .* $([ -e .hidden ] && (cat .hidden | xargs ls -d 2> /dev/null))'
alias lo='losetup --show --find --partscan'
alias ls='ls -lh --color --group-directories-first'
alias lx='stat -c "%A %a %n"'
alias lspci='lspci -nn'
alias lspkg='for PKG in */; do \ls ${PKG%/}/${PKG%/}-+([0-9])*.pkg.* 2> /dev/null; done'
alias load='\uptime | awk -F'\'': '\'' '\''{print $NF}'\'''
alias md='apostrophe'
alias mddetail='sudo mdadm --detail /dev/md/*'
alias mirrors='reflector -p https --latest 5 --score 5'
alias neofetch='clear; echo; neofetch'
alias npm='pnpm'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$" | esc'
alias path='echo $PATH | tr : \\n'
alias pick='gpick'
alias pidcomm='ps -o comm= -p'
alias piduser='ps -o uname= -p'
alias ping='ping -4'
alias ping6='\ping -6'
alias psof='ps --no-headers -o user,pid,cmd -C'
alias sc='systemctl'
alias scenabled='sc list-unit-files --state=enabled'
alias scfail='sc list-units --state=failed'
alias sensors='sensors -A'
alias serial='screen /dev/ttyUSB0 115200'
alias serve='serve -n'
alias sl='ls'
alias sshfs='sshfs -o idmap=user'
alias startx='exec startx'
alias stopwatch="watch -pt -n0.1 'date +\"%H:%M:%S.%1N\"'"
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias ucode='grep -m1 ^microcode /proc/cpuinfo | awk '\''{print $NF;}'\'''
alias udevprops='udevadm info -q property'
alias unlock-gpg='echo | gpg --sign > /dev/null'
alias updatedb='sudo updatedb'
alias uptime='\uptime | sed "s/^.*\(up.*\),\s\+[0-9]\s\+user.*/\1/g"'
alias vmstat='vmstat -S M'
alias watch='watch --color'
alias wanhostname='dig +short -x $(wanip) | sed "s/\.$//" #'
alias wanip='dig +short ch txt whoami.cloudflare @1.1.1.1 | xargs'
alias webcam='fswebcam --no-banner --resolution 1920x1080'
alias xpatch='(cd / && patch -p0)'

# --- SCRIPTS ------------------------------------------------------------------

for SCRIPT in $HOME/.bash.d/*.sh; do
  [ -x "$SCRIPT" ] && . "$SCRIPT"
done

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
[ -r $HOME/.bashrc.$USER ] && . $HOME/.bashrc.$USER
