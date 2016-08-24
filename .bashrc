[ -z "$PS1" ] && return
umask 0022

# -- [ ENV VARS ] --------------------------------------------------------------
export HOSTNAME=$(echo ${HOSTNAME} | tr '[A-Z]' '[a-z]')

if [[ $TERM == xterm* ]] || [ $TERM = "screen" ]; then
  export PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME%%.*}]: ${PWD/$HOME/~}\007"'
  unset MOST_INITFILE
  PROMPT_COLOR=$(cat ${HOME}/.promptcolor 2> /dev/null)
else
  export MOST_INITFILE="$HOME/.mostrc.console"
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
export GPGKEY='C7F4A2F0'
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export HISTFILE=/dev/null
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LOCAL_PACKAGE_SOURCES=${XDG_DOWNLOAD_DIR:-$HOME}
export PAGER=most
export PATH=$HOME/bin/local:$HOME/bin:$HOME/.rvm/bin:$PATH
export PS1='[\[\e[${PROMPT_COLOR:-0}m\]\u@${HOSTNAME%%.*}\[\e[0m\]: \W]\$ '
export SYSTEMD_PAGER=cat

unset MAILCHECK

# -- [ FUNCTIONS ] -------------------------------------------------------------

function dm() {
  mount | grep ^$(df ${1:-.} --output=source 2> /dev/null | grep -v ^Filesystem$)\  2> /dev/null
}

function ac3() {
  [ ! -z "${1}" -a -f "${1}" ] || return
  ffmpeg -i "${1}" -c:v copy -c:a ac3 -vbr 0 "${1%.*}-AC3.mp4"
}

function gitignore() { curl -L -s https://www.gitignore.io/api/$@ ;}

function murder() {
  [ -n "${1}" ] || return 1
  PIDS=$(ps --no-headers -o pid -u ${1})
  [ -n "${PIDS}" ] && sudo kill -9 ${PIDS}
}

# -- [ ALIASES ] ---------------------------------------------------------------
alias bakfiles='updatedb && locate -r "\~$" | grep -v \/node_modules\/'
alias bd='. bd -s &> /dev/null'
alias clip='xclip -selection c'
alias cordova='HOME=$(pwd) cordova'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -h'
alias docker='sudo docker'
alias du='du -h'
alias em='emacs'
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias epoch='date +%s'
alias fmount='fusermount'
alias free='free -m'
alias gpga='gpg --armor --symmetric --cipher-algo AES256'
alias gpp='g++'
alias grep='grep --color'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias la='ls -d .*'
alias ls='ls -lh --color'
alias md='md2html'
alias mime='file -b --mime-type'
alias pacfiles='updatedb && locate -r "\.pac\(new\|save\|orig\)$"'
alias sc='systemctl'
alias screen='TERM=screen-256color screen'
alias serial='screen /dev/ttyUSB0 115200'
alias sl='ls'
alias sshfs='sshfs -o idmap=user'
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias updatedb='sudo updatedb'
alias vmstat='vmstat -S M'
alias x11vnc='x11vnc -usepw'
alias xpatch='(cd / && patch -p0)'

for SCRIPT in $HOME/.bash/*.sh; do
  [ -x "$SCRIPT" ] && . "$SCRIPT"
done

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
[ -r $HOME/.bashrc.$USER ] && . $HOME/.bashrc.$USER
