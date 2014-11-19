[ -z "$PS1" ] && return
[ -r "$HOME/.bash/complete.sh" ] && . "$HOME/.bash/complete.sh"
[ -r "$HOME/.bash/xdg.sh" ] && . "$HOME/.bash/xdg.sh"

# -- [ ENV VARS ] --------------------------------------------------------------
if [[ $TERM == xterm* ]] || [ $TERM = "screen" ]; then
  export PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME%%.*}]: ${PWD/$HOME/~}\007"'
  unset MOST_INITFILE
  USER_COLOR=$(cat ${HOME}/.user-color 2> /dev/null)
else
  export MOST_INITFILE="$HOME/.mostrc.console"
fi

export BC_ENV_ARGS="$HOME/.bcrc"
export BROWSER=firefox
export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export DIFFPROG=ediff
export EDITOR=emacs
export EDITOR_X11=subl
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export LOCAL_PACKAGE_SOURCES=${XDG_DOWNLOAD_DIR:-$HOME}
export PAGER=most
export PATH=$HOME/bin/local:$HOME/bin:$HOME/.rvm/bin:$PATH
export PS1='[\[\e[${USER_COLOR:-0}m\]\u@\h\[\e[0m\]: \W]\$ '
export SYSTEMD_PAGER=cat

unset MAILCHECK

# -- [ FUNCTIONS ] -------------------------------------------------------------

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# -- [ ALIASES ] ---------------------------------------------------------------
alias bd='. bd -s &> /dev/null'
alias bright='sudo bright'
alias clip='xclip -selection c'
alias ddstat='sudo killall -s USR1 /usr/bin/dd'
alias df='df -h'
alias du='du -h'
alias em='emacs'
alias epoch='date +%s'
alias fmount='fusermount'
alias free='free -m'
alias gpp='g++'
alias grep='grep --color'
alias jc='journalctl'
alias journalctl='journalctl -aq'
alias la='ls -dlh .* --color'
alias ls='ls -lh --color'
alias md='md2html'
alias mime='file -b --mime-type'
alias node='env NODE_NO_READLINE=1 rlwrap node'
alias pacfiles='updatedb && locate pac{new,sav,orig}'
alias packer='TMPDIR=/dev/shm packer'
alias sc='systemctl'
alias sshfs='sshfs -o idmap=user'
alias su='sudo su'
alias top='htop'
alias tree='gvfs-tree'
alias updatedb='sudo updatedb'
alias vmstat='vmstat -S M'
