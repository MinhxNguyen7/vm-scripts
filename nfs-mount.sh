#! /bin/bash

echo "Setting up NFS share..."
sudo apt install -y nfs-common
read -p "Enter NFS share IP (leave blank to skip): " NFS_IP
if [ ! -z $NFS_IP ]; then # If not empty
  read -p "Enter NFS share name (without slash): " NFS_NAME
  read -p "Enter mount point: " NFS_MOUNT

  sudo mkdir $NFS_MOUNT
  sudo echo "$NFS_IP:/$NFS_NAME $NFS_MOUNT nfs defaults 0 0" | sudo tee -a "/etc/fstab"
  sudo mount $NFS_MOUNT
fi