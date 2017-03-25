#!/bin/bash

[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

xrdb -merge ~/.Xresources

xset +fp /usr/share/fonts/local
xset fp rehash

xbindkeys

export DE=xfce
exec xfce4-session
