#!/bin/bash

export XDG_CURRENT_DESKTOP=XFCE

xhost +si:localuser:root
xset s off
xset dpms 3600 3600 3600

xrdb -merge ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash

rm -fr $XDG_CACHE_HOME/thumbnails
ln -s $XDG_DATA_HOME/thumbnails $XDG_CACHE_HOME/thumbnails

. /etc/X11/xinit/xinitrc.d/30-gtk3-nocsd.sh
. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

display-day
one xautolock -corners 000- -cornersize 1 -time 30 -secure -locker /usr/local/bin/lock &
(sleep 2 && font-touch) &

(
  xbindkeys
  sleep 5
  killall -u $USER xbindkeys
  xbindkeys
) &

exec xfce4-session
