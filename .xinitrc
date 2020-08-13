#!/bin/bash

export XDG_CURRENT_DESKTOP=XFCE

xrdb -merge ~/.Xresources

xset +fp /usr/share/fonts/local
xset fp rehash

xset s off
xset dpms 3600 3600 3600

xhost +si:localuser:root

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

exec xfce4-session
