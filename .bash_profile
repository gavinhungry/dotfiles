set -a
source /etc/environment
set +a

export PATH=$HOME/bin/local:$HOME/bin:$HOME/.local/bin${PATH:+:${PATH#:}}

export PROMPT_COLOR=$(prompt-color)
term-color

[ -f $HOME/.loadkeys ] && type loadkeys &> /dev/null && loadkeys $HOME/.loadkeys

if [ "$TERM" == linux ]; then
  setterm -blank 60
  setterm -powerdown 60
fi

unset MAILCHECK

USER_DIRS=${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs
if [ -r $USER_DIRS ]; then
  . $USER_DIRS
  for DIR in $(cat $USER_DIRS | grep -o '^XDG_[^=]*'); do
    export $DIR
  done
fi

export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/gl-shader-cache
export BC_ENV_ARGS=$HOME/.bcrc
export BROWSER=firefox
export CASTCTL_PLAYER=${CASTCTL_NAME// /_}
export DIFFPROG=ediff
export EDITOR=emacs
export EDITOR_X11=subl
export FZF_DEFAULT_OPTS='--color=bg+:#444444,fg+:yellow,hl+:green'
export GPGKEY=1450B358FCC7992D8C6160F352CC07C8C7F4A2F0
export GTK_OVERLAY_SCROLLING=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoredups
export HISTFILE=/dev/null
export HOSTNAME=$(echo ${HOSTNAME%%.*} | tr '[A-Z]' '[a-z]')
export LD_LIBRARY_PATH=/usr/local/lib
export LESS='-SRic --tilde --shift 1 -z16'
export LESSHISTFILE=-
export LS_ARGS='-lh --color --group-directories-first'
export MANLESS='man $MAN_PN\: page %d/%D, line %l/%L'
export MANPAGER="less $LESS +Gg"
export NEOFETCH_PREFER_GTK2_RC=1
export NODE_NO_WARNINGS=1
export NODE_PATH="$HOME/.local/lib/node_modules"
export PACMAN_AUTH=/usr/bin/sudo
export PAGER=less
export QT_QPA_PLATFORMTHEME=qt5ct
export SYSTEMD_EDITOR=$EDITOR
export SYSTEMD_PAGER=cat
export TERMINAL=roxterm
export WATCH_INTERVAL=1
export XCURSOR_THEME='Vanilla-DMZ'

if [ ! -S "$SSH_AUTH_SOCK" ]; then
  if [ "$SSH_AUTH_SINGLE_INSTANCE" == 1 ]; then
    if [ -f $XDG_CACHE_HOME/.ssh-agent ]; then
      _SSH_AGENT=$(cat $XDG_CACHE_HOME/.ssh-agent)
    else
      _SSH_AGENT=$(ssh-agent -s)
      echo $_SSH_AGENT > $XDG_CACHE_HOME/.ssh-agent
    fi

    eval $_SSH_AGENT > /dev/null
  else
    eval $(ssh-agent -s) > /dev/null
  fi
fi

[ -n "$SSH_TTY" ] && motd
[ "$TERM" != screen ] && screen -ls &> /dev/null && screen -ls

[ -r $HOME/.termcap -a -n "$TERM" ] && . $HOME/.termcap
[ -r $HOME/.bash_profile.local ] && . $HOME/.bash_profile.local
[ -r $HOME/.bash_profile.$USER ] && . $HOME/.bash_profile.$USER
[ -r $HOME/.bashrc -a "$1" != NO_BASHRC ] && . $HOME/.bashrc

:
