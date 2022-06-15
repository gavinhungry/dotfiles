type _completion_loader &> /dev/null || _completion_loader() { false ;}

__commands() {
  COMPREPLY=($(compgen -c -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __commands cw ew lw ow pkgw emi

__users() {
  COMPREPLY=($(compgen -u -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __users gecos

__packages() {
  COMPREPLY=($(compgen -W '$(pacman -Sqs); $(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __packages pkgsource

__local_packages() {
  COMPREPLY=($(compgen -W '$(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __local_packages pkgver

__pnames() {
  local cur prev words cword
  _init_completion || return
  _pnames "$cur"
}
complete -F __pnames pidage pidenv psof

__modparam() {
  local cur prev words cword
  _init_completion || return
  _installed_modules "$cur"
}
complete -F __modparam modparam

_completion_loader man
complete -F _man eman

_completion_loader systemctl
complete -F _systemctl sc

_completion_loader ssh
complete -F _ssh ssh-mount ssh-umount
