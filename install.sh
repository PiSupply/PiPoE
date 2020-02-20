#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else
   sudo apt-get install -y git whiptail wiringpi #Installs packages which might be missing

   if grep "4" /proc/device-tree/model; then
   cd /tmp
   wget https://project-downloads.drogon.net/wiringpi-latest.deb
   sudo dpkg -i wiringpi-latest.deb
   sudo rm wiringpi-latest.deb
   cd ~
fi


   PiPoEDir="PiPoE"
   if [ -d "$PiPoEDir" ]; then
        whiptail --title "Installation aborted" --msgbox "$PiPoEDir already exists, please remove it and restart the installation" 8 78
        exit
   fi

   git clone https://github.com/PiSupply/PiPoE.git
   mkdir /opt/pipoe
   cp $PiPoEDir/removepower.sh /opt/pipoe
   cp $PiPoEDir/pipoe.service /etc/systemd/system

   systemctl enable /etc/systemd/system/pipoe.service
   whiptail --title "Installation complete" --msgbox "Pi PoE installation complete.\n\nRemember that the shutdown -h or poweroff commands will now remove power on the Pi.\n\nYou can now reboot the system to enable the service" 12 78
fi
