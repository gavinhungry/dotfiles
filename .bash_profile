[ -f $HOME/.loadkeys ] && type loadkeys &> /dev/null && loadkeys $HOME/.loadkeys
unset MAILCHECK

export BC_ENV_ARGS="$HOME/.bcrc"
export BROWSER=google-chrome
export COMP_WORDBREAKS=${COMP_WORDBREAKS//[;=]}=
export DIFFPROG=ediff
export EDITOR=emacs
export EDITOR_X11=subl
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export HISTFILE=/dev/null
export HOSTNAME=$(echo ${HOSTNAME} | tr '[A-Z]' '[a-z]')
export LD_LIBRARY_PATH=/usr/local/lib
export LOCAL_PACKAGE_SOURCES=${XDG_DOWNLOAD_DIR:-$HOME}
export NODE_PATH=/usr/lib/node_modules
export PAGER=most
export PATH=$HOME/bin/local:$HOME/bin:$PATH
export QT_QPA_PLATFORMTHEME=qt5ct
export SYSTEMD_EDITOR=$EDITOR
export SYSTEMD_PAGER=cat

USER_DIRS=${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
if [ -r $USER_DIRS ]; then
  . $USER_DIRS
  for DIR in $(cat $USER_DIRS | grep -o '^XDG_[^=]*'); do
    export $DIR
  done
fi

[ -r $HOME/.bashrc -a "$1" != NO_BASHRC ] && . $HOME/.bashrc
[ "$TERM" != screen ] && screen -ls &> /dev/null && screen -ls
