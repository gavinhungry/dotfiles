type _completion_loader &> /dev/null || _completion_loader() { false ;}

__commands() {
  COMPREPLY=($(compgen -c -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __commands cw ew ow pkg emi

__users() {
  COMPREPLY=($(compgen -u -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __users gecos

__packages() {
  COMPREPLY=($(compgen -W '$(pacman -Sqs); $(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __packages pkgsource

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

_completion_loader journalctl
complete -F _journalctl jc

_completion_loader man
complete -F _man eman

_completion_loader systemctl
complete -F _systemctl sc
