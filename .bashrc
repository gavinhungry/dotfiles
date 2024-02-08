[ -z "$PS1" ] && return
[ "$(id -un)" == "$(id -gn)" ] && umask 0002 || umask 0022

stty -echoctl

# --- ENVIRONMENT --------------------------------------------------------------

export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export GPG_TTY=$(tty)

# --- PROMPT--------------------------------------------------------------------

unset PROMPT_COMMAND

PROMPT_COLOR=$(prompt-color)
if [ -e $HOME/.prompt-color-invert ]; then
  PROMPT_COLOR=$(prompt-color --invert)
fi

_DASH=$(echo $'\u2014')
[ -n "$STY" -o "$TERM" == 'screen' ] && _DASH='--'

_pwdstr() { [ "$PWD" != "$HOME" ] && echo "  $_DASH  $(basename "$PWD")" ;}

export PS1='\[\e[1;${PROMPT_COLOR}m\]\u@${HOSTNAME}\[\e[0m\] \W \$ '
PS1+='\[\e]2;${_TERM_TITLE}\u@${HOSTNAME}$(_pwdstr)\a\]'

[ -n "$TERM_TITLE" ] && t "$TERM_TITLE"
unset TERM_TITLE

# --- FUNCTIONS ----------------------------------------------------------------

aliased() { alias $1 | cut -d= -f2- | sed -r "s/(^'|'$)//g" ;}
cmds() { compgen -c | sort | grep --color "${1:-$^}" ;}
cw() { [ -f "$(type -p $1)" ] && cat "$(type -p $1)" || type "$1" 2> /dev/null ;}
dif() { diff --color=always "$@" | less ;}
dm() { findmnt -no SOURCE,TARGET,FSTYPE,OPTIONS -T ${1:-.} | column -t ;}
emi() { emacs --insert <("$@" 2>&1) ;}
ew() { [ -f "$(which $1)" ] && $EDITOR "$(which $1)" ;}
f() {
  DIR=$(
    fd -t d -H -E .git -E node_modules . "${1:-.}" |\
    fzf -e --height=16 --keep-right --layout=reverse --prompt 'f> '
  )

  [ -n "$DIR" ] && cd "$DIR"
}
lw() { [ -f "$(which $1)" ] && ls -lh --color "$(which $1)" ;}
ow() { [ -f "$(which $1)" ] && open "$(which $1)" ;}
highlight() { grep --color -E "$1|$" "${@:2}" ;}
term() { exo-open --launch TerminalEmulator ${1:-.} ;}
timer() { nohup timer "$@" > /dev/null 2>&1 & }
t() {
  if [ ${#@} == 0 ]; then
    unset _TERM_TITLE
    return
  fi

  _TERM_TITLE="$@  $_DASH  "
}

_hidden() {
  local DIRS=()
  for ARG in "$@"; do
    [ -d "$ARG" ] && DIRS+=("$ARG")
  done

  [ ${#DIRS[@]} -gt 1 ] && return
  local DIR=${DIRS[0]:-${PWD}}

  [ -e "$DIR"/.hidden ] || return
  (cd $DIR && esc .hidden | xargs /usr/bin/ls -d 2> /dev/null | uniq)
}
_ls() {
  local CMD='/usr/bin/ls $LS_ARGS "$@" '
  while read -r HIDE; do
    CMD+="--hide '$HIDE' "
  done <<<$(_hidden "$@" | esc)
  eval $CMD
}
_la() {
  local CMD='/usr/bin/ls $LS_ARGS -d '
  [ $(ls -d .* 2> /dev/null | wc -l) -ge 1 ] && CMD+='.* '
  CMD+=$(_hidden | esc)
  eval $CMD
}

# --- ALIASES ------------------------------------------------------------------

alias -- -='cd - > /dev/null'
alias ..='cd ..'
alias ,='open .'
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
alias dmesg='sudo dmesg -w'
alias dt='df -t $(\df --output=fstype / | sed 1d)'
alias du='du -h -d1'
alias edid='sudo get-edid | edid-decode'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias exifstrip='exiftool -all='
alias ffmpeg='ffpb'
alias fmount='fusermount'
alias free='free -h'
alias fumount='fmount -u'
alias gh='github'
alias gpge='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='GREP_USE_SPACE_SEPARATOR=1 grep --color'
alias htop='htop -U -d5'
alias ignoreeof='set -o ignoreeof'
alias iodev='iostat -dym 1 1'
alias iotop='sudo iotop -o'
alias iowatch='S_COLORS=always watch -n0 $(aliased iodev)'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias kurl='curl --ntlm --negotiate -u :'
alias lo='losetup --show --find --partscan'
alias load='\uptime | awk -F'\'': '\'' '\''{print $NF}'\'''
alias ls='_ls'
alias la='_la'
alias lspci='lspci -nn'
alias lspkg='for PKG in */; do \ls ${PKG%/}/${PKG%/}-+([0-9])*.pkg.* 2> /dev/null; done'
alias lx='stat -c "%A %a %n"'
alias man='eman'
alias md='apostrophe'
alias mddetail='sudo mdadm --detail /dev/md/*'
alias mirrors='reflector -p https --latest 5 --score 5'
alias motd='motd --color'
alias npm='pnpm'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$" | esc'
alias path='echo $PATH | tr : \\n'
alias pick='gpick'
alias pidcomm='ps -o comm= -p'
alias piduser='ps -o uname= -p'
alias ping6='\ping -6'
alias ping='ping -4'
alias psof='ps --no-headers -o user,pid,cmds -C'
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
alias uptime='uptime -p'
alias vmstat='vmstat -S M'
alias wanhostname='dig +short -x $(wanip) | sed "s/\.$//" #'
alias wanip='dig +short ch txt whoami.cloudflare @1.1.1.1 | xargs'
alias watch='watch --color'
alias webcam='fswebcam --no-banner --resolution 1920x1080'
alias xpatch='(cd / && patch -p0)'
alias xterm='xterm -bg black -fg white'

# --- SCRIPTS ------------------------------------------------------------------

for SCRIPT in $HOME/.bash.d/*.sh; do
  [ -x "$SCRIPT" ] && . "$SCRIPT"
done

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
[ -r $HOME/.bashrc.$USER ] && . $HOME/.bashrc.$USER

:
