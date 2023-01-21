#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"

OS=$(uname -or)

case $OS in
    *Darwin*) ICON="" ;;
    *Android*) ICON="" ;;
    *microsoft*) ICON="" ;;
    *BSD*) 
      DISTRO=$(uname -s)
      case $DISTRO in
        *FreeBSD*) ICON="" ;;
        *OpenBSD*) ICON="" ;;
      esac
    ;;
    *Linux*) 
      DISTRO=$(awk -F= '/^ID=/ {print $2}' /etc/os-release 2> /dev/null | sed 's/"//g')
      case $DISTRO in
        arch) ICON="" ;;
        void) ICON="" ;;
        centos) ICON="" ;;
        ubuntu) ICON="" ;;
        fedora) ICON="" ;;
        alpine) ICON="" ;;
        artix) ICON="" ;;
        gentoo) ICON="" ;;
        debian) ICON="" ;;
        mint) ICON="" ;;
        manjaro) ICON="" ;;
        popos) ICON="" ;;
        parrot) ICON="" ;;
        kali) ICON="" ;;
        guix) ICON="" ;;
        nixos) ICON="" ;;
        endeavour) ICON="" ;;
        deepin) ICON="" ;;
        archlabs) ICON="" ;;
        almalinux) ICON="" ;;
        raspberry_pi) ICON="" ;;
        redhat) ICON="" ;;
        slackware) ICON="" ;;
        zorin) ICON="" ;;
        elementary) ICON="" ;;
        solus) ICON="" ;;
        rocky_linux) ICON="" ;;
        opensuse*) ICON="" ;;
        budgie) ICON="" ;;
        *) ICON="" ;;
      esac
      ;;
    *) ICON="" ;;
esac


PROMPT="%B%{$fg[yellow]%}$ICON [%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%m%{$fg[blue]%}]%  %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "
