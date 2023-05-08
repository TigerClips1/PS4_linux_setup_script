#!/bin/bash

echo "running the script"


#first command
sudo dnf update -x kernel*,libdrm*,mesa*,xorg-x11-drv-a
sudo dnf install discord
sudo su
cd /
sudo touch /swapfile
sudo fallocate -l 8G /swapfile -x
chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "Done"
sudo reboot