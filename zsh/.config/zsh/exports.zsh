#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.local/share/fnm:$PATH
export PATH=$HOME/.local/share/pnpm:$PATH
export PATH=$HOME/.local/share/neovim/bin:$PATH
export XDG_CURRENT_DESKTOP="Wayland"

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"

export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/.miniconda/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
		. "$HOME/.miniconda/etc/profile.d/conda.sh"
	else
		export PATH="$HOME/.miniconda/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<
