#!/bin/bash

export XDG_CURRENT_DESKTOP=XFCE

. /etc/X11/xinit/xinitrc.d/30-gtk3-nocsd.sh
. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

rm -fr $XDG_CACHE_HOME/thumbnails
ln -s $XDG_DATA_HOME/thumbnails $XDG_CACHE_HOME/thumbnails

xrdb -merge ~/.Xresources
xhost +si:localuser:root
xset +fp /usr/share/fonts/local
xset fp rehash
xset s off
xset dpms 3600 3600 3600
one xautolock -corners 000- -cornersize 1 -time 30 -secure -locker /usr/local/bin/lock &
display-day

xbindkeys

(
  until pidof -q xfce4-panel; do
    sleep 1
  done

  sleep 2

  font-touch
  emerald --replace &

  sleep 2

  killall -u $USER xbindkeys
  xbindkeys
) &

[ -e $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
[ -e $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

exec xfce4-session
