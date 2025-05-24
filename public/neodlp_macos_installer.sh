#!/bin/bash

# Config
OWNER="neosubhamoy"
REPO="neodlp"
DOWNLOAD_DIR=~/Downloads

# Detect system architecture
echo "🔃 Checking system requirements..."
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    ASSET_NAME="NeoDLP_aarch64.app.tar.gz"
    echo "🧠 Detected Apple Silicon Mac (arm64)"
elif [[ "$ARCH" == "x86_64" ]]; then
    ASSET_NAME="NeoDLP_x64.app.tar.gz"
    echo "🧠 Detected Intel-based Mac (x86_64)"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Get the latest release tag from GitHub API
TAG=$(curl -s https://api.github.com/repos/$OWNER/$REPO/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Construct the full download URL
URL="https://github.com/$OWNER/$REPO/releases/download/$TAG/$ASSET_NAME"

# Download the release asset
echo "📥 Downloading $ASSET_NAME from $TAG..."
curl -L -o "$DOWNLOAD_DIR/$ASSET_NAME" "$URL"

# Extract the archive
cd "$DOWNLOAD_DIR"
tar -xzf "$ASSET_NAME"

# Move the .app to /Applications directory
APP_NAME="NeoDLP.app"
echo "📦 Moving $APP_NAME to /Applications directory (sudo required)"
sudo mv "$APP_NAME" /Applications/

echo "✅ Installed NeoDLP successfully!"