#! /bin/bash

sudo apt update
sudo apt install -y curl

curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-get update
sudo apt-get -y install tailscale

sudo tailscale up

rm /etc/apt/sources.list.d/tailscale.list
rm /usr/share/keyrings/tailscale-archive-keyring.gpg
printf %"$COLUMNS"s |tr " " "-"
