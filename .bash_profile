loadkeys $HOME/.loadkeys

[ -d /tmp/.$USER-cache ] || mkdir -m 0700 /tmp/.$USER-cache
[ -r $HOME/.bashrc ] && . $HOME/.bashrc
