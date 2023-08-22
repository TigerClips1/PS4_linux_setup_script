#!/bin/sh

#first command
sleep 5

echo "running the script" #leting the user know it running the script

echo "Please find your timezone by running this command timedatectl list-timezones" #discalmer

sleep 1

echo "to find the all keyborad layout run localectl list-keymaps"

sleep 1

sleep 3 #3 secord the script will start

read -rp "Enter the swap you want: " swap #user input

sleep 1

read -rp "Please Enter the timezone you want: " timezone  #user input

sleep 1

read -rp "Please Enter any keyborad layout you want: " layout #testing

sleep 1

#ask if the user want to update

sleep 1

while true; do
    read -p "Do you wish to install this program/update?" yn
    case $yn in
        [Y]* ) sudo apt update && sudo apt-mark hold *mesa* xserver-xorg-video-amdgpu* libdrm* && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt install discord neofetch htop git  ; break;;
        [N]* ) break;;
        * ) echo "Please answer Y or N.";;
    esac
done


#make sure the number the user want is a number not a string

if [ "${swap:-0}" -eq "${swap:-1}" 2>/dev/null ]; then
    echo "making swapspace"
    cd /
    sudo touch /swapfile
    sudo dd if=/dev/zero of=/swapfile bs=1G count=$swap status=progress
    sudo chmod 0600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
 echo "please enter a Number" >&2 #error
 exit
fi 

echo "seting up the timezone"
#setup the timezone
sudo timedatectl set-timezone $timezone
sleep 1
sudo ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
sleep 1
sudo timedatectl set-ntp true

sleep 1
#setting up keybored layout and language
echo "setting up keybored layout and systen language" 
sleep 1

sudo dpkg-reconfigure keyboard-configuration

sleep 1

sudo dpkg-reconfigure locales

sleep 1

echo "Done" #outro

echo "script By TigerClips1" #credit
echo "PS4 will reboot in 10 secord"
sleep 10

sudo reboot

exit

#end
