#!/bin/bash

# Helper function to log messages with visual separators
log_message() {
    separator="==============================================="
    message="$1"
    echo "$separator"
    echo "$message"
    echo "$separator"
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

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    log_message "🟡 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# List of packages to install with descriptions and special install methods if needed
PACKAGES=(
    "git:Git Version Control"
    "stow:GNU Stow - Symlink Farm Manager"
    "neovim:Neovim Text Editor"
    "bat:Bat - A Cat Clone with Syntax Highlighting"
    "exa:Exa - A Modern Replacement for ls"
    "fzf:Fuzzy Finder for Terminal"
    "zsh:Zsh Shell"
    "zoxide:Zoxide - A smarter cd command"
)

# Install packages using the detected package manager
for package_info in "${PACKAGES[@]}"; do
    package_name="${package_info%%:*}"
    package_description="${package_info#*:}"
    
    if is_package_installed "$package_name"; then
        log_message "🟢 $package_description ($package_name) is already installed. Skipping..."
    else
        log_message "🟡 Installing $package_description ($package_name)..."

        brew install "$package_name"
    fi
        
    if is_package_installed "$package_name"; then
        log_message "✅ $package_description ($package_name) installed successfully."
    else
        log_message "❌ Failed to install $package_description ($package_name). Please install it manually."
    fi
done

# Install Node.js via NVM and use LTS version
if ! is_package_installed "nvm"; then
    log_message "🟡 Installing NVM (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    source ~/.nvm/nvm.sh
fi

# Install zap for managing zsh packages
if ! is_package_installed "zap"; then
    log_message "🟡 Installing Zap..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
    source ~/.zshrc
fi

# Create an alias for the bat package
if is_package_installed "batcat"; then
    mkdir -p ~/.local/bin
    ln -s "$(command -v batcat)" ~/.local/bin/bat
    log_message "✅ Alias for 'bat' created in ~/.local/bin."
fi

log_message "🟢 All packages installed successfully."
