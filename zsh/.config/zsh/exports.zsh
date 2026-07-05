#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR=vi
export GPG_TTY=$(tty)
export MANWIDTH=999
export BUN_INSTALL=$HOME/.bun
export PNPM_HOME=$HOME/.local/share/pnpm
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.local/share/fnm:$PATH
export PATH=$PNPM_HOME:$PATH
export PATH=$HOME/.local/share/neovim/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
export PATH=/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

_fnm_lazy() {
  unset -f fnm node npm npx corepack _fnm_lazy 2>/dev/null
  eval "$(command fnm env --use-on-cd)"
}
for _c in fnm node npm npx corepack; do
  eval "${_c}() { _fnm_lazy; ${_c} \"\$@\"; }"
done
unset _c

eval "$(zoxide init zsh)"
