[ -z "$PS1" ] && return
[ "$(id -un)" == "$(id -gn)" ] && umask 0002 || umask 0022

# -- [ ENV VARS ] --------------------------------------------------------------
export HOSTNAME=$(echo ${HOSTNAME} | tr '[A-Z]' '[a-z]')

if [[ $TERM == xterm* ]] || [ $TERM = "screen" ]; then
  export PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME%%.*}]: ${PWD/$HOME/~}\007"'
  unset MOST_INITFILE
  PROMPT_COLOR=$(cat ${HOME}/.promptcolor 2> /dev/null)
else
  PROMPT_COLOR=$(cat ${HOME}/.promptcolor.console 2> /dev/null)
fi

if [ "$LC_TERM" == 1 -a "$PROMPT_COLOR" == "0;90" ]; then
  unset PROMPT_COLOR
fi

export BC_ENV_ARGS="$HOME/.bcrc"
export BROWSER=google-chrome
export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export DIFFPROG=ediff
export EDITOR=emacs
export EDITOR_X11=subl
export GPG_TTY=$(tty)
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export HISTFILE=/dev/null
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LOCAL_PACKAGE_SOURCES=${XDG_DOWNLOAD_DIR:-$HOME}
export PAGER=most
export PATH=$HOME/bin/local:$HOME/bin:$HOME/.rvm/bin:$PATH
export PS1='[\[\e[${PROMPT_COLOR:-0}m\]\u@${HOSTNAME%%.*}\[\e[0m\]: \W]\$ '
export QT_QPA_PLATFORMTHEME=qt5ct
export SYSTEMD_EDITOR=$EDITOR
export SYSTEMD_PAGER=cat

unset MAILCHECK

# -- [ FUNCTIONS ] -------------------------------------------------------------

dm() {
  mount | grep ^$(df ${1:-.} --output=source 2> /dev/null | grep -v ^Filesystem$)\  2> /dev/null
}

__enc_audio() {
  [ ! -z "${1}" -a -f "${1}" ] || return
  ffmpeg -i "${1}" -c:v copy -c:a $2 -vbr 0 "${1%.*}-$2.mp4"
}

ac3() {
  __enc_audio "$1" ac3
}

aac() {
  __enc_audio "$1" aac
}

ifhost() {
  [ $# -ge 1 ] && host $(ifdata -pa $1) 2> /dev/null
}

# -- [ ALIASES ] ---------------------------------------------------------------
alias bakfiles='updatedb && locate -r "\~$\|#[^/]*#$"'
alias bd='. bd -s &> /dev/null'
alias clip='xclip -selection c'
alias cordova='HOME=$(pwd) cordova'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -h'
alias dmesg='dmesg -w'
alias docker='sudo docker'
alias du='du -h'
alias edid='sudo get-edid | edid-decode'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias epoch='date +%s'
alias exifstrip='exiftool -all='
alias fmount='fusermount'
alias free='free -m'
alias gpga='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='grep --color'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias la='ls -d .*'
alias ls='ls -lh --color'
alias makepkg='GNUPGHOME=/etc/pacman.d/gnupg makepkg --nocheck'
alias md='md2html'
alias mime='file -b --mime-type'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$"'
alias pm2='sudo -u pm2 pm2'
alias pm2env='sudo -u pm2 env'
alias sc='systemctl'
alias screen='TERM=screen-256color screen'
alias serial='screen /dev/ttyUSB0 115200'
alias sl='ls'
alias sshfs='sshfs -o idmap=user'
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias udevprops='udevadm info -q property'
alias updatedb='sudo updatedb'
alias vmstat='vmstat -S M'
alias x11vnc='x11vnc -usepw'
alias xpatch='(cd / && patch -p0)'

for SCRIPT in $HOME/.bash/*.sh; do
  [ -x "$SCRIPT" ] && . "$SCRIPT"
done

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
[ -r $HOME/.bashrc.$USER ] && . $HOME/.bashrc.$USER
