#!/bin/bash

# Config
OWNER="neosubhamoy"
REPO="neodlp"
DOWNLOAD_DIR=~/Downloads

# Check if NeoDLP is already installed
echo "### === NeoDLP MacOS Curl-Bash Installer === ###"
echo "🔃 Checking system requirements..."
if [ -d "/Applications/NeoDLP.app" ]; then
    echo "❗ NeoDLP is already installed at /Applications/NeoDLP.app"
    echo "🛑 Installation aborted."
    exit 0
fi

# Detect system architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    ASSET_NAME="NeoDLP_aarch64.app.tar.gz"
    echo "🧠 Detected Apple Silicon Mac (arm64)"
elif [[ "$ARCH" == "x86_64" ]]; then
    ASSET_NAME="NeoDLP_x64.app.tar.gz"
    echo "🧠 Detected Intel-based Mac (x86_64)"
else
    echo "❌ Unsupported architecture: $ARCH"
    echo "🛑 Installation aborted."
    exit 1
fi

# Get the latest release tag from GitHub API
TAG=$(curl -s https://api.github.com/repos/$OWNER/$REPO/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Construct the full download URL
URL="https://github.com/$OWNER/$REPO/releases/download/$TAG/$ASSET_NAME"

# Download the release asset
echo "⬇️ Downloading $ASSET_NAME from tag $TAG..."
curl -L -o "$DOWNLOAD_DIR/$ASSET_NAME" "$URL"

# Extract the archive
cd "$DOWNLOAD_DIR"
tar -xzf "$ASSET_NAME"

# Move the .app to /Applications directory
APP_NAME="NeoDLP.app"
echo "📦 Moving $APP_NAME to /Applications directory (sudo required)"
sudo mv "$APP_NAME" /Applications/

# Clean up the downloaded archive
echo "🧹 Cleaning up..."
rm "$DOWNLOAD_DIR/$ASSET_NAME"

echo "✅ Installed NeoDLP successfully!"