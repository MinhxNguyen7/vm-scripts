#! /bin/bash

# For relative invokation
PARENT_PATH=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# Set up NFS mount
cd "$PARENT_PATH"
bash nfs-mount.sh

# From https://www.geekbitzone.com/posts/2022/proxmox/plex-lxc/install-plex-in-proxmox-lxc/

# Prep
echo "Preparing..."
sudo apt update
sudo apt upgrade -y
sudo apt install curl gnupg -y
printf %"$COLUMNS"s |tr " " "-" # Horizontal line

# Install Plex
echo "Downloading Plex..."
curl -sS https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex.gpg > /dev/null 
echo "deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" > /etc/apt/sources.list.d/plexmediaserver.list
echo "Installing Plex"
apt update
apt install plexmediaserver -y
printf %"$COLUMNS"s |tr " " "-" # Horizontal line