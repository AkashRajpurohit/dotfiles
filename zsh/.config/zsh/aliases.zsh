#!/bin/sh

command_exists () {
  hash "$1" 2> /dev/null
}

# Changing "ls" to "exa"
if command_exists exa; then
  alias ls='exa -al --color=always --group-directories-first --icons' # my preferred listing
  alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
  alias ll='exa -l --color=always --group-directories-first --icons'  # long format
  alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
  alias l.='exa -a | egrep "^\."'
else
  alias la='ls -A' # List all files/ includes hidden
  alias ll='ls -lAFh' # List all files, with full details
  alias lb='ls -lhSA' # List all files sorted by biggest
  alias lm='ls -tA -1' # List files sorted by last modified
fi

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
alias dud='du -d 1 -h' # List sizes of files within directory
alias duf='du -sh *' # List total size of current directory

# System Monitoring
alias memhog='ps -eo pid,ppid,cmd,%mem --sort=-%mem | head' # Processes consuming most mem
alias cpuhog='ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head' # Processes consuming most cpu
alias cpuinfo='lscpu' # Show CPU Info
alias distro='cat /etc/*-release' # Show OS info
alias ports='netstat -tulanp' # Show open ports

# Copy / pasting
alias cpwd='pwd | pbcopy' # Copy current path
alias pa='pbpaste' # Paste clipboard contents

# External Services
alias myip='curl icanhazip.com'
alias weather='curl wttr.in'
alias weather-short='curl "wttr.in?format=3"'
alias worldinternet='curl https://status.plaintext.sh/t'
cs() {
  # Ask cheat.sh website for details about a Linux command.
  curl -m 10 "http://cheat.sh/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
}
mkcd() {
    mkdir -p $@ && cd $@;
}

# Random
alias yolo='git add .; git commit -m "feat: :man_dancing: YOLO"; git push'
bye() {
  sudo shutdown -h now
}
sudorun() {
  sudo $(fc -ln -1)
}
alias plz=sudorun
alias docker-compose-update='docker-compose pull; docker-compose down --remove-orphans; docker-compose rm; docker-compose up -d'

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
    start)
      sudo systemctl start "$service"
      ;;
    stop)
      sudo systemctl stop "$service"
      ;;
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
alias start_service="manage_service start"
alias stop_service="manage_service stop"
alias restart_service="manage_service restart"
alias status_service="manage_service status"
alias enable_service="manage_service enable"
alias disable_service="manage_service disable"
alias enable_now_service="manage_service enable-now"

alias running_services="systemctl list-units --type=service --state=running"
log_service() {
  local service="$1"

  journalctl --unit $service.service --boot --pager-end
}

# Replace batcat to bat if it is installed
if command_exists batcat; then
  alias bat='batcat'
fi

# Replace vi with vim if it is installed
if command_exists vim; then
  alias vi='vim'
fi

# Replace vim with nvim if it is installed
if command_exists nvim; then
  alias vim='nvim'
fi

