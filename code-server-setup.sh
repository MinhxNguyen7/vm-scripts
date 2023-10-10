#! /bin/bash

# For relative invokation
PARENT_PATH=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

echo "Preparing..."

# Update apt-get
sudo apt-get update

# Get tools
sudo apt-get install -y wget gpg curl

printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# NFS Setup
cd "$PARENT_PATH"
sudo bash nfs-mount.sh

# TailScale optional
read -p "Install TailScale? (Y/n): " INSTALL_TAILSCALE
echo ""
if [[ "$INSTALL_TAILSCALE" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        curl -fsSL https://tailscale.com/install.sh | sh
        sudo tailscale up # Start TailScale
        printf %"$COLUMNS"s |tr " " "-" # Horizontal line
    else
        echo "Skipping TailScale installation"
fi

# Web development tools optional
read -p "Install web development tools (NodeJS, NPM, pnpm)? (Y/n): " INSTALL_WEB
echo ""
if [[ "$INSTALL_WEB" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        sudo apt install nodejs npm
        sudo npm i -g pnpm n
        sudo n stable
        printf %"$COLUMNS"s |tr " " "-" # Horizontal line
    else
        echo "Skipping web development tools installation"
fi

# Install VSCode
sudo bash install-vscode.sh
printf %"$COLUMNS"s |tr " " "-" # Horizontal line
