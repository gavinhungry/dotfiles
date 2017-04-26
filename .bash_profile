[ -f $HOME/.loadkeys ] && type loadkeys &> /dev/null && loadkeys $HOME/.loadkeys
[ -r $HOME/.bashrc ] && . $HOME/.bashrc

screen -ls &> /dev/null && screen -ls
