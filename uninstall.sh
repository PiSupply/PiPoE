#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else

   systemctl disable /etc/systemd/pipoe.service

   rm /opt/pipoe/removepower.sh
   rm /opt/pipoe -d
   rm /etc/systemd/system/pipoe.service

   whiptail --title "Uninstall complete" --msgbox "Pi PoE uninstall complete. You are safe to remove the folder PiPoE." 8 78
fi

