#!/bin/bash

# Config
OWNER="neosubhamoy"
REPO="neodlp"
DOWNLOAD_DIR=~/Downloads

# Check if NeoDLP is already installed
echo "### === NeoDLP Installer (Linux) === ###"
echo "🔍 Checking system requirements..."
if command -v neodlp &> /dev/null; then
    echo "❗ NeoDLP is already installed at $(which neodlp)"
    read -p "❓ Would you like to reinstall/update? (y/N): " -r REPLY
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "🛑 Installation aborted."
        exit 0
    fi
    echo "🔄 Proceeding with reinstallation/update..."
fi

# Detect system architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    ASSET_ARCH="arm64"
    echo "🧠 Detected ARM64 architecture"
elif [[ "$ARCH" == "x86_64" ]]; then
    ASSET_ARCH="x64"
    echo "🧠 Detected x86_64 architecture"
else
    echo "❌ Unsupported architecture: $ARCH"
    echo "🛑 Installation aborted."
    exit 1
fi

# Get the latest release tag and version from GitHub API
TAG=$(curl -s https://api.github.com/repos/$OWNER/$REPO/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
VERSION=${TAG#v}

# Detect package manager and set asset name accordingly
if command -v apt &> /dev/null; then
    ASSET_NAME="NeoDLP_${VERSION}_$([[ "$ASSET_ARCH" == "x64" ]] && echo "amd64" || echo "arm64").deb"
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y"
    echo "🐧 Detected debian/ubuntu based distro"
elif command -v dnf &> /dev/null; then
    ASSET_NAME="NeoDLP-${VERSION}-1.$([[ "$ASSET_ARCH" == "x64" ]] && echo "x86_64" || echo "aarch64").rpm"
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
    echo "🐧 Detected rhel/fedora based distro"
elif command -v yum &> /dev/null; then
    ASSET_NAME="NeoDLP-${VERSION}-1.$([[ "$ASSET_ARCH" == "x64" ]] && echo "x86_64" || echo "aarch64").rpm"
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y"
    echo "🐧 Detected rhel/fedora based distro"
elif command -v zypper &> /dev/null; then
    ASSET_NAME="NeoDLP-${VERSION}-1.$([[ "$ASSET_ARCH" == "x64" ]] && echo "x86_64" || echo "aarch64").rpm"
    PKG_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install -y"
    echo "🐧 Detected opensuse based distro"
elif command -v pacman &> /dev/null; then
    echo "🐧 Detected arch based distro"

    # Check if yay is installed
    if command -v yay &> /dev/null; then
        echo "✅ yay is already installed"
    else
        echo "ℹ️ yay not found, installing... (sudo required)"
        # Install yay
        sudo pacman -S --needed --noconfirm git base-devel
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
        rm -rf /tmp/yay
        
        if command -v yay &> /dev/null; then
            echo "✅ yay installed successfully"
        else
            echo "❌ Failed to install yay"
            echo "🛑 Installation aborted."
            exit 1
        fi
    fi
    
    # Install NeoDLP from AUR using yay
    echo "📦 Installing NeoDLP from AUR using yay..."
    yay -S --noconfirm neodlp
    
    echo "✅ Installed NeoDLP successfully!"
    exit 0
else
    echo "❌ Unsupported distro: no supported package manager found (apt, dnf, yum, zypper, pacman)"
    echo "🛑 Installation aborted."
    exit 1
fi

# Construct the full download URL
URL="https://github.com/$OWNER/$REPO/releases/download/$TAG/$ASSET_NAME"

# Download the release asset
echo "⬇️ Downloading $ASSET_NAME from tag $TAG..."
curl -L -o "$DOWNLOAD_DIR/$ASSET_NAME" "$URL"

# Install the package
echo "📦 Installing $ASSET_NAME using $PKG_MANAGER (sudo required)"
$INSTALL_CMD "$DOWNLOAD_DIR/$ASSET_NAME"

# Clean up the downloaded package
echo "🧹 Cleaning up..."
rm "$DOWNLOAD_DIR/$ASSET_NAME"

echo "✅ Installed NeoDLP successfully!"