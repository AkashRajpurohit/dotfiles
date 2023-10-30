#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export GPG_TTY=$(tty)
export EDITOR="vim"
export TERMINAL="kitty"
export BROWSER="brave"
export MANPAGER='vim +Man!'
export MANWIDTH=999
export GOPATH=$HOME/.local/share/go
export BUN_INSTALL=$HOME/.bun
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.local/share/fnm:$PATH
export PATH=$HOME/.local/share/pnpm:$PATH
export PATH=$HOME/.local/share/neovim/bin:$PATH
export XDG_CURRENT_DESKTOP="Wayland"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
