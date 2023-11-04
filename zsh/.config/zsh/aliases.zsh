#!/bin/sh
alias j='z'
alias f='zi'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'
alias mkcd='mkdir -p && cd' # make directory and cd into it

# Function to re-run the previous command with sudo
sudorun() {
  sudo $(fc -ln -1)
}

alias fuck="sudorun"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias duf='du -h d1' # show file sizes in a folder for depth=1

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# gpg encryption
alias gpg='gpg2'
# verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
# receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

# systemd
manage_service() {
  local action="$1"
  local service="$2"

  case "$action" in
    restart)
      sudo systemctl restart "$service"
      ;;
    status)
      sudo systemctl status "$service"
      ;;
    enable)
      sudo systemctl enable "$service"
      ;;
    disable)
      sudo systemctl disable "$service"
      ;;
    enable-now)
      sudo systemctl enable --now "$service"
      ;;
    *)
      echo "Usage: manage-service {restart|status|enable|disable|enable-now} <service>"
      return 1
      ;;
  esac
}

# Dynamic aliases for managing services
alias restart_service="manage_service restart"
alias status_service="manage_service status"
alias enable_service="manage_service enable"
alias disable_service="manage_service disable"
alias enable_now_service="manage_service enable --now"

alias running_services='systemctl list-units --type=service --state=running'

# Replace cat with bat
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# Replace vim and vi with nvim if exists
if command -v nvim &> /dev/null; then
  alias vi='vim'
  alias vim='nvim'
fi

