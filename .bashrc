[ -z "$PS1" ] && return
[ "$(id -un)" == "$(id -gn)" ] && umask 0002 || umask 0022

stty -echoctl

# --- ENVIRONMENT --------------------------------------------------------------

PROMPT_COLOR=97 # local
if [ -n "$SSH_TTY" ]; then
  PROMPT_COLOR=93 # SSH
  [ -r $HOME/.promptcolor ] && PROMPT_COLOR=$(cat $HOME/.promptcolor) # SSH user
fi
[ $(id -u) -eq 0 ] && PROMPT_COLOR=91 # root

export PS1='[\[\e[1;${PROMPT_COLOR}m\]\u@${HOSTNAME}\[\e[0m\]: \W]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/\~}\007"'

export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export GPG_TTY=$(tty)

# --- FUNCTIONS ----------------------------------------------------------------

aliased() { alias $1 | cut -d= -f2- | sed -r "s/(^'|'$)//g" ;}
cate() { echo -e "$(cat $1)" ;}
cmd() { compgen -c | sort | grep --color "${1:-$^}" ;}
cw() { [ -f "$(type -p $1)" ] && cat "$(type -p $1)" || type "$1" 2> /dev/null ;}
dif() { diff --color=always "$@" | less ;}
dm() { findmnt -no SOURCE,TARGET,FSTYPE,OPTIONS -T ${1:-.} | column -t ;}
dnxhr() { ffpb -i "$1" -c:v dnxhd -profile:v dnxhr_hq "DNxHR-${1%.*}.mxf" ;}
du() { command du "${1:-.}" -hLd 1 2> /dev/null | sort -Vfk2.4 | sed '1h;1d;$G' ;}
epoch() { [ -n "$1" ] && date -d @"$1" || date +%s ;}
emi() { emacs --insert <("$@" 2>&1) ;}
ew() { [ -f "$(which $1)" ] && $EDITOR "$(which $1)" ;}
lw() { [ -f "$(which $1)" ] && ls -lh --color "$(which $1)" ;}
ow() { [ -f "$(which $1)" ] && open "$(which $1)" ;}
term() { exo-open --launch TerminalEmulator --working-directory ${1:-.} ;}

eman() {
  if [ -z "$*" ]; then man; return; fi
  man -w $* > /dev/null && \
  emacs --eval "(progn (man \"$*\") (kill-buffer-and-window) \
                (run-with-idle-timer 0 nil 'linum-mode 0))"
}

# --- ALIASES ------------------------------------------------------------------

alias -- -='cd - > /dev/null'
alias ..='cd ..'
alias acme.sh='sudo acme.sh --home /etc/ssl/acme.sh'
alias alsamixer='alsamixer --view=all'
alias bakfiles='updatedb && locate -r "\~$\|#[^/]*#$" | grep -v /node_modules/ | esc'
alias bd='. bd -s &> /dev/null'
alias bios='cat /sys/devices/virtual/dmi/id/bios_version'
alias cls='tput reset'
alias clx='history -c; cls'
alias cpu-x='cpu-x --ncurses'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -Th'
alias dt='df -t $(\df --output=fstype / | sed 1d)'
alias dmesg='sudo dmesg -w'
alias edid='sudo get-edid | edid-decode'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias esc='xargs -I {} sh -c '\''printf %q "{}" && echo'\'''
alias exifstrip='exiftool -all='
alias ffmpeg='ffpb'
alias fmount='fusermount'
alias fumount='fmount -u'
alias free='free -h'
alias gpge='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='GREP_USE_SPACE_SEPARATOR=1 grep --color'
alias htop='TERM=$(echo $TERM | sed -r "s/^(xterm|screen).*/\1-256color/") htop -d5'
alias ignoreeof='set -o ignoreeof'
alias iotop='sudo iotop -o'
alias iodev='iostat -dym 1 1'
alias iowatch='watch -n0 $(aliased iodev)'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias kurl='curl --ntlm --negotiate -u :'
alias la='ls -d .* $([ -e .hidden ] && (cat .hidden | xargs ls -d 2> /dev/null))'
alias ls='ls -lh --color --group-directories-first'
alias lx='stat -c "%A %a %n"'
alias lspkg='for PKG in */; do \ls ${PKG%/}/${PKG%/}-+([0-9])*.pkg.* 2> /dev/null; done'
alias load='uptime | awk -F'\'': '\'' '\''{print $NF}'\'''
alias md='md2html'
alias mddetail='sudo mdadm --detail /dev/md/*'
alias mirrors='reflector -p https --latest 5 --score 5'
alias model='cat /sys/devices/virtual/dmi/id/product_name'
alias motd='cate /etc/motd'
alias npm-script='npm run-script'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$" | esc'
alias path='echo $PATH | tr : \\n'
alias pidcomm='ps -o comm='
alias ping='ping -4'
alias ping6='\ping -6'
alias psof='ps --no-headers -o user,pid,cmd -C'
alias rgb='sudo openrgb -c'
alias sc='systemctl'
alias scu='sc --user'
alias scenabled='sc list-unit-files --state=enabled'
alias scfail='sc list-units --state=failed'
alias sensors='sensors -A'
alias serial='screen /dev/ttyUSB0 115200'
alias sl='ls'
alias sshfs='sshfs -o idmap=user'
alias startx='exec startx'
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias udevprops='udevadm info -q property'
alias updatedb='sudo updatedb'
alias vmstat='vmstat -S M'
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
