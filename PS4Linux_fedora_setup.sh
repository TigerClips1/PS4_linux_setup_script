#!/bin/bash

#first command

echo "running the script" #leting the user know it running the script

echo "Please find your timezone by running this command timedatectl list-timezones" #discalmer

read -rp "Enter the swap you want: " swap #user input

echo -n "Please Enter the timezone you want: " #user input

read timezone  #read what timezone the user pick

#ask if the user want to update
while true; do
    read -p "Do you wish to install this program/update?" yn
    case $yn in
        [Y]* ) sudo dnf install discord htop neofetch && sudo dnf update -x kernel*,libdrm*,mesa*,xorg-x11-drv-a  ; break;;
        [N]* ) exit;;
        * ) echo "Please answer Y or N.";;
    esac
done


#make sure the number the user want is a number not a string
echo "making swapspace"

if [ "${swap:-0}" -eq "${swap:-1}" 2>/dev/null ]; then
    cd /
    sudo touch /swapfile
    sudo fallocate -l $swap /swapfile -x
    sudo chmod 0600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
 echo "please enter a Number" >&2 #error
fi 

echo "seting up the timezone"
#setup the timezone
sudo timedatectl set-timezone $timezone
sudo ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
sudo timedatectl set-ntp true

echo "Done" #outro

echo "script By TigerClips1" #credit
sudo reboot

#end
