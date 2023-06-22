#! /bin/bash

# Update apt-get
sudo apt-get update

# Get tools
sudo apt-get install -y wget gpg

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install apt-transport-https
sudo apt-get install sublime-text

# Install VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y code

# Install Jetbrains Toolbox
sudo apt-get install -y libfuse2 # Have to get libfuse2 for AppImage
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $DIR
./jetbrains-toolbox
cd ..
rm -r $DIR
rm jetbrains-toolbox.tar.gz

# SSH
sudo apt install -y openssh-server

# Terminator
sudo apt install -y terminator

# NFS Setup
sudo apt install -y nfs-common
read -p "Enter NFS share IP (leave blank to skip): " NFS_IP
if [ ! -z $NFS_IP ]; then # If not empty
  read -p "Enter NFS share name (without slash): " NFS_NAME
  read -p "Enter mount point: " NFS_MOUNT

  sudo mkdir $NFS_MOUNT
  sudo echo "$NFS_IP:/$NFS_NAME $NFS_MOUNT nfs defaults 0 0" >> "/etc/fstab"
  sudo mount $NFS_MOUNT
fi


