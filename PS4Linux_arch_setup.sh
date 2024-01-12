#!/bin/bash

#first command
sleep 5

printf "running the script" #leting the user know it running the script

printf "Please find your timezone by running this command timedatectl list-timezones" #discalmer

sleep 1

printf "to find the all keyborad layout run localectl list-keymaps"

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
        [Y]* ) printf "IgnorePkg = lib32-mesa* lib32-libva-mesa-driver mesa-git lib32-libdrm-git lib32-mesa-git libdrm-git xf86-video-amdgpu-git lib32-llvm-libs llvm-libs lib32-mesa libdrm mesa* lib32-libdrm llvm-libs-git lib32-llvm-libs-git lib32-libelf lib32-vulkan-mesa* lib32-opencl-mesa lib32-mesa-vdpau lib32-vulkan libva-mesa opencl-mesa vulkan* xf86-video-amdgpu libry libelf rapidyaml lib32-vulkan-radeon*
                    IgnoreGroup = mesa* libdrm* llvm* vulkan* libry* libelf* rapidyaml*  lib32-vulkan-radeon*" | sudo tee -a /etc/pacman.conf && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman-key --refresh-keys &&
                    sudo pacman -Syy && sudo pacman -S archlinux-keyring && sudo pacman -Syyu && sudo pacman -Scc && sudo pacman -S neofetch git htop; break;;
        [N]* ) break;;
        * ) printf "Please answer Y or N.";;
    esac
done

#make sure the number the user want is a number not a string

if [ "${swap:-0}" -eq "${swap:-1}" 2>/dev/null ]; then
    printf "making swapspace"
    cd /
    sudo touch /swapfile
    sudo dd if=/dev/zero of=/swapfile bs=1G count=$swap status=progress
    sudo chmod 0600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    printf '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
 printf "please enter a Number" >&2 #error
 exit
fi 

printf "seting up the timezone"
#setup the timezone
sudo timedatectl set-timezone $timezone
sleep 1
sudo ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
sleep 1
sudo timedatectl set-ntp true
sleep 1
printf "seting up your key layout"

#should load the keyborad layout you pick for exmple UK your keyborad layout  will be like a UK keyborad layout
sudo loadkeys $layout
sleep 1
sudo localectl set-keymap --no-convert $layout
sleep 1
printf "Change the /etc/X11/xorg.conf.d/00-keyboard.conf to your layout for exmple fr to us"
sleep 1 
sudo setxkbmap $layout

sleep 1

printf "Done" #outro

printf "script By TigerClips1" #credit

printf "PS4 will reboot in 10 secord"

sleep 10

sudo reboot

exit

#end
