#!/bin/bash

# Helper function to log messages with visual separators
log_message() {
    separator="==============================================="
    message="$1"
    echo "$separator"
    echo "$message"
    echo "$separator"
    echo ""
}

# Function to check if a package is installed
is_package_installed() {
    package_name="$1"
    # Mapping of package names to executable names
    declare -A package_executables
    package_executables["neovim"]="nvim"
    package_executables["bat"]="batcat"  # Example for 'bat' package

    executable_name="${package_executables[$package_name]:-$package_name}"
    if command -v "$executable_name" &>/dev/null; then
        return 0  # Package is installed
    else
        return 1  # Package is not installed
    fi
}

# Check if the script is running as root (or with sudo)
if [ "$EUID" -ne 0 ]; then
    log_message "❌ Please run this script as root or using sudo."
    exit 1
fi

# Detect the Linux distribution
if [ -x "$(command -v apt-get)" ]; then
    # Debian/Ubuntu
    PACKAGE_MANAGER="apt-get"
elif [ -x "$(command -v yum)" ]; then
    # CentOS/RHEL
    PACKAGE_MANAGER="yum"
elif [ -x "$(command -v dnf)" ]; then
    # Fedora
    PACKAGE_MANAGER="dnf"
else
    log_message "❌ Unsupported Linux distribution. Please install the required packages manually."
    exit 1
fi

# List of packages to install with descriptions and special install methods if needed
PACKAGES=(
    "git:Git Version Control"
    "curl:cURL"
    "unzip:Unzip"
    "stow:GNU Stow - Symlink Farm Manager"
    "zsh:Zsh Shell"
    "neovim:Neovim Text Editor"
    "bat:Bat - A Cat Clone with Syntax Highlighting"
    "exa:Exa - A Modern Replacement for ls"
    "fzf:Fuzzy Finder for Terminal"
)

# Install packages using the detected package manager
for package_info in "${PACKAGES[@]}"; do
    package_name="${package_info%%:*}"
    package_description="${package_info#*:}"
    
    if is_package_installed "$package_name"; then
        log_message "🟢 $package_description ($package_name) is already installed. Skipping..."
    else
        log_message "🟡 Installing $package_description ($package_name)..."
        
        case $PACKAGE_MANAGER in
            "apt-get")
                sudo apt-get install -y "$package_name"
                ;;
            "yum")
                sudo yum install -y "$package_name"
                ;;
            "dnf")
                sudo dnf install -y "$package_name"
                ;;
        esac
    fi
        
    if is_package_installed "$package_name"; then
        log_message "✅ $package_description ($package_name) installed successfully."
    else
        log_message "❌ Failed to install $package_description ($package_name). Please install it manually."
    fi
done

# Install fnm for managing node versions
if ! is_package_installed "fnm"; then
    log_message "🟡 Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
fi

# Install zoxide
if ! is_package_installed "zoxide"; then
    log_message "🟡 Installing zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Install zap for managing zsh packages
if ! is_package_installed "zap"; then
    log_message "🟡 Installing Zap..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
fi

log_message "🟢 All packages installed successfully."

log_message "🟢 Changing shell to ZSH"

chsh -s $(which zsh)

log_message "🟢 Logout and login back and re-run the script once again to verify"

