#!/bin/bash

SourcePath=https://raw.githubusercontent.com/swgamez/Retroflagshutdown/main

#-----------------------------------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /

#-----------------------------------------------------------

mkdir /userdata/RetroFlag
sleep 2s
script=/userdata/RetroFlag/SafeShutdown_gpi2.py
wget -O  $script "$SourcePath/batocera_SafeShutdown_gpi2.py"
#-----------------------------------------------------------

sleep 2s
DIR=/userdata/system/custom.sh

if grep -q "python $script" "$DIR";
	then
		if [ -x "$DIR" ];
			then 
				echo "Executable script already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo "python $script &" >> $DIR
		chmod +x $DIR
		echo "Executable script configured."
fi
#-----------------------------------------------------------

echo "RetroFlag Pi Case Switch installation done. Will now reboot after 3 seconds."
sleep 3
shutdown -r now
#-----------------------------------------------------------
