#!/usr/bin/env bash

# Check if the invoked target includes reboot
if [[ `systemctl list-units --type target` != *"reboot"*  ]]
# It is a shutdown or poweroff
then
# Prepares to remove power in about 30 seconds
	/usr/bin/gpio -g mode 17 out
        /usr/bin/gpio -g write 17 0
        sleep 30
fi
# If it is a reboot then nothing happens

