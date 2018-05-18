#!/bin/bash

export X_TTY=$(tty)
[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

xrdb -merge ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash

exec xfce4-session
