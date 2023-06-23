#! /bin/bash

# For relative invokation
PARENT_PATH=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

echo "Preparing..."

# Update apt-get
sudo apt-get update

# Get tools
sudo apt-get install -y wget gpg curl

printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Install Sublime Text
echo "Installing Sublime Text"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install apt-transport-https
sudo apt-get install sublime-text
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Install VSCode
echo "Installing VSCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y code
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Install Jetbrains Toolbox
echo "Installing Jetbrains Toolbox"
sudo apt-get install -y libfuse2 # Have to get libfuse2 for AppImage
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $DIR
./jetbrains-toolbox
cd ..
rm -r $DIR
rm jetbrains-toolbox.tar.gz
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# SSH
echo "Installing OpenSSH Server"
sudo apt install -y openssh-server
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Terminator
echo "Installing Terminator"
sudo apt install -y terminator
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# NFS Setup
cd "$PARENT_PATH"
sudo bash nfs-mount.sh

# TailScale optional
while true; do
    read -p "Install TailScale? (Y/n): " INSTALL_TAILSCALE
    echo ""
    if [[ "$INSTALL_TAILSCALE" == "Y" ]]; then
        curl -fsSL https://tailscale.com/install.sh | sh
        sudo tailscale up # Start TailScale
        break
    fi
    if [[ "$INSTALL_TAILSCALE" == "n" ]]; then
        break
    echo "Invalid input. Valid inputs: Y for yes, n for no"
    fi
done
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Web development tools optional
while true; do
    read -p "Install web development tools (NodeJS, NPM, pnpm)? (Y/n): " INSTALL_WEB
    echo ""
    if [[ "$INSTALL_TAILSCALE" == "Y" ]]; then
        sudo apt install nodejs npm
        sudo npm i -g pnpm
        break
    fi
    if [[ "$INSTALL_TAILSCALE" == "n" ]]; then
        break
    echo "Invalid input. Valid inputs: Y for yes, n for no"
    fi
done
printf %"$COLUMNS"s |tr " " "-" # Horizontal line
