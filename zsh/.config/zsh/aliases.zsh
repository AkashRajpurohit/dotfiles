#!/bin/sh

command_exists () {
  hash "$1" 2> /dev/null
}

# Changing "ls" to "exa"
if command_exists exa; then
  alias ls='exa -al --color=always --group-directories-first' # my preferred listing
  alias la='exa -a --color=always --group-directories-first'  # all files and dirs
  alias ll='exa -l --color=always --group-directories-first'  # long format
  alias lt='exa -aT --color=always --group-directories-first' # tree listing
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
alias cheat='curl cheat.sh/'
alias worldinternet='curl https://status.plaintext.sh/t'

# Random
alias plz="fc -l -1 | cut -d' ' -f2- | xargs sudo" # Re-run last cmd as root
alias yolo='git add .; git commit -m "feat: :man_dancing: YOLO"; git push'

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

# Replace batcat to bat if it is installed
if command -v batcat &> /dev/null; then
  alias bat='batcat'
fi

# Replace vim and vi with nvim if it is installed
if command -v nvim &> /dev/null; then
  alias vi='vim'
  alias vim='nvim'
fi

