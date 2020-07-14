[ -f $HOME/.loadkeys ] && type loadkeys &> /dev/null && loadkeys $HOME/.loadkeys

if [ "$TERM" == linux ]; then
  setterm -blank 60
  setterm -powerdown 60
fi

unset MAILCHECK

export PATH=$HOME/bin/local:$HOME/bin:$HOME/.local/bin${PATH:+:${PATH#:}}

export ALSA_CARD_ID=$(asound-id $ALSA_CARD)
export BC_ENV_ARGS="$HOME/.bcrc"
export BROWSER=firefox
export DIFFPROG=ediff
export EDITOR=emacs
export EDITOR_X11=subl
export GTK_OVERLAY_SCROLLING=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export HISTFILE=/dev/null
export HOSTNAME=$(echo ${HOSTNAME%%.*} | tr '[A-Z]' '[a-z]')
export LD_LIBRARY_PATH=/usr/local/lib
export LESS='-SRic --tilde --shift 1 -z16'
export LESSHISTFILE=-
export MANLESS='man $MAN_PN\: page %d/%D, line %l/%L'
export MANPAGER="less $LESS +Gg"
export NODE_NO_WARNINGS=1
export NODE_PATH=$HOME/.local/lib/node_modules
export PAGER=less
export QT_QPA_PLATFORMTHEME=qt5ct
export RDP_ICON_PATH=~/.icons/rdp.png
export SYSTEMD_EDITOR=$EDITOR
export SYSTEMD_PAGER=cat

USER_DIRS=${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
if [ -r $USER_DIRS ]; then
  . $USER_DIRS
  for DIR in $(cat $USER_DIRS | grep -o '^XDG_[^=]*'); do
    export $DIR
  done
fi

[ -r $HOME/.termcap -a -n "$TERM" ] && . $HOME/.termcap
[ -r $HOME/.lesskey ] && lesskey -o $HOME/.less $HOME/.lesskey
[ -r $HOME/.bashrc -a "$1" != NO_BASHRC ] && . $HOME/.bashrc
[ "$TERM" != screen ] && screen -ls &> /dev/null && screen -ls
