[ -z "$PS1" ] && return
[ "$(id -un)" == "$(id -gn)" ] && umask 0002 || umask 0022

# --- ENVIRONMENT --------------------------------------------------------------

[ $(id -u) -eq 0 ] && PROMPT_COLOR=91 ||
PROMPT_COLOR=$(cat $HOME/.promptcolor 2> /dev/null)
export PS1='[\[\e[1;${PROMPT_COLOR:-97}m\]\u@${HOSTNAME}\[\e[0m\]: \W]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/\~}\007"'

export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export GPG_TTY=$(tty)

# --- FUNCTIONS ----------------------------------------------------------------

cmd() { compgen -c | sort | grep --color "${1:-$^}" ;}
cw() { [ -f "$(type -p $1)" ] && cat "$(type -p $1)" ;}
dif() { diff --color=always "$@" | less ;}
dm() { findmnt -no SOURCE,TARGET,FSTYPE,OPTIONS -T ${1:-.} | column -t ;}
du() { command du "${1:-.}" -hLd 1 2> /dev/null | sort -Vfk2.4 | sed '1h;1d;$G' ;}
emi() { emacs --insert <("$@" 2>&1) ;}
ew() { [ -f "$(type -p $1)" ] && $EDITOR "$(type -p $1)" ;}
ow() { [ -f "$(type -p $1)" ] && open "$(type -p $1)" ;}
term() { exo-open --launch TerminalEmulator --working-directory ${1:-.} ;}

eman() {
  if [ -z "$*" ]; then man; return; fi
  man -w $* > /dev/null && \
  emacs --eval "(progn (man \"$*\") (kill-buffer-and-window) \
                (run-with-idle-timer 0 nil 'linum-mode 0))"
}

# --- ALIASES ------------------------------------------------------------------

alias ..='cd ..'
alias acme.sh='sudo acme.sh --home /etc/ssl/acme.sh'
alias bakfiles='updatedb && locate -r "\~$\|#[^/]*#$" | grep -v /node_modules/ | esc'
alias bd='. bd -s &> /dev/null'
alias clip='xclip -selection c'
alias cls='tput reset'
alias cordova='HOME=$(pwd) cordova'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -Th'
alias dt='df -t $(\df --output=fstype / | sed 1d)'
alias dmesg='sudo dmesg -w'
alias docker='sudo docker'
alias edid='sudo get-edid | edid-decode'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias epoch='date +%s'
alias esc='xargs -I {} sh -c '\''printf %q "{}" && echo'\'''
alias exifstrip='exiftool -all='
alias fmount='fusermount'
alias fumount='fmount -u'
alias free='free -h'
alias gpge='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='GREP_USE_SPACE_SEPARATOR=1 grep --color'
alias htop='TERM=$(echo $TERM | sed -r "s/^(xterm|screen).*/\1-256color/") htop'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias kernel='curl -s https://www.kernel.org/releases.json | jq -r .latest_stable.version'
alias kurl='curl --negotiate -u :'
alias la='ls -d .*'
alias ls='ls -lh --color'
alias lx='stat -c "%A %a %n"'
alias load='uptime | awk -F'\'': '\'' '\''{print $NF}'\'''
alias md='md2html'
alias mime='file -b --mime-type'
alias motd='cat /etc/motd'
alias npm-script='npm run-script'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$" | esc'
alias path='echo $PATH | tr : \\n'
alias pidcomm='ps -o comm='
alias ping='ping -4'
alias ping6='\ping -6'
alias psof='ps --no-headers -o user,pid,cmd -C'
alias sc='systemctl'
alias serial='screen /dev/ttyUSB0 115200'
alias sl='ls'
alias sshfs='sshfs -o idmap=user'
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias udevprops='udevadm info -q property'
alias updatedb='sudo updatedb'
alias vmstat='vmstat -S M'
alias wanip='curl -s https://ifconfig.co'
alias xpatch='(cd / && patch -p0)'

# --- SCRIPTS ------------------------------------------------------------------

for SCRIPT in $HOME/.bash.d/*.sh; do
  [ -x "$SCRIPT" ] && . "$SCRIPT"
done

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
[ -r $HOME/.bashrc.$USER ] && . $HOME/.bashrc.$USER
