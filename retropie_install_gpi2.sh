#!/bin/bash
filewebsite="https://raw.githubusercontent.com/swgamez/Retroflagshutdown/main"
sleep 2s
#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

#Step 1) Download Python script-----------------------------
cd /etc/modprobe.d
wget --no-check-certificate -O  "alsa-base.conf" "$filewebsite""/alsa-base.conf"

fi
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo "RetroFlag Pi Case installation done. Will now reboot after 3 seconds."
sleep 3s
sudo reboot
#-----------------------------------------------------------
