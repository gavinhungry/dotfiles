#!/bin/bash

export XDG_CURRENT_DESKTOP=XFCE

# ROXTERM_DIR=$XDG_CONFIG_HOME/roxterm.sourceforge.net
# SCHEME=$(grep -s ^colour_scheme= $ROXTERM_DIR/Profiles/Default | cut -d= -f2)
# export TERM_BG=$(grep -s ^background= $ROXTERM_DIR/Colours/$SCHEME | cut -d= -f2)

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

rm -fr $XDG_CACHE_HOME/thumbnails
ln -s $XDG_DATA_HOME/thumbnails $XDG_CACHE_HOME/thumbnails

xrdb -merge ~/.Xresources
xhost +si:localuser:root

xset +fp /usr/share/fonts/local
xset fp rehash
xset s off
xset dpms 3600 3600 0
display-mode day

one xautolock -corners 000- -cornersize 1 -time 10 -secure -locker /usr/local/bin/lock &

[ -e $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap

xbindkeys

(
  until pidof -q xfce4-panel; do sleep 1; done

  font-touch
  emerald --replace &
) &

[ -e $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

dbus-update-activation-environment --systemd --all
systemctl --user restart xfce4-session.target

exec xfce4-session
