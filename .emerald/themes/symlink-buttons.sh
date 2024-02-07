#!/bin/bash

for THEME_DIR in $HOME/.emerald/themes/*/; do
  cd $THEME_DIR || continue
  [ -e ./theme.ini -a -e ./buttons.png ] || continue

  for PNG in buttons.*.png; do
    ln -sf buttons.png $PNG
  done
done
