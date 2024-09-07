#!/bin/bash

# Step 1) Check if root ####################################
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

SourcePath=https://raw.githubusercontent.com/swgamez/Retroflagshutdown/main

#-----------------------------------------------------------
sleep 2s

mount -o remount, rw /flash
mount -o remount, rw /

#Download Python script-----------------------------
mkdir /userdata/RetroFlag/
sleep 2s
script=/userdata/RetroFlag/SafeShutdown.py

wget -O  $script "$SourcePath/recalbox_SafeShutdown_gpi2.py"
wget -O  "/userdata/RetroFlag/lcdfirst.sh" "$SourcePath/lcdfirst.sh"
wget -O  "/userdata/RetroFlag/lcdnext.sh" "$SourcePath/lcdnext.sh"
#-----------------------------------------------------------

sleep 2s
# DIR=/userdata/system/custom.sh
DIR=/userdata/system/custom.sh

if grep -q "python $script &" "$DIR";
	then
		if [ -x "$DIR" ];
			then 
				echo "Executable script already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo "python $script & sh /userdata/system/lcdfirst.sh" >> $DIR
		chmod +x $DIR
		chmod +x /userdata/system/lcdfirst.sh
		chmod +x /userdata/system/lcdnext.sh
		echo "Executable script configured."
fi
#-----------------------------------------------------------

echo "RetroFlag GPI2 Case Switch installation done. Will now reboot after 3 seconds."
sleep 3
shutdown -r now
#-----------------------------------------------------------
