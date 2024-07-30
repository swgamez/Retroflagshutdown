#!/bin/bash
make /boot writable---------------------------------
sleep 2s
filewebsite=https://raw.githubusercontent.com/swgamez/Retroflagshutdown/main

mount -o remount, rw /boot
mount -o remount, rw /


Download Python script-----------------------------
mkdir /userdata/RetroFlag/RetroFlag
sleep 2s

script=/userdata/RetroFlag/SafeShutdown.py

if [ -e $script ];
	then
		wget --no-check-certificate -O  $script "$filewebsite""/recalbox_SafeShutdown_gpi2.py"
	else
		wget --no-check-certificate -O  $script "$filewebsite""/recalbox_SafeShutdown_gpi2.py"
fi
wget --no-check-certificate -O  "/userdata/RetroFlag/lcdfirst.sh" "$filewebsite""/lcdfirst.sh"
wget --no-check-certificate -O  "/userdata/RetroFlag/lcdnext.sh" "$filewebsite""/lcdnext.sh"
#wget --no-check-certificate -O  "/userdata/RetroFlag/LCD.sh" "$filewebsite""/LCD.sh"

#-----------------------------------------------------------

sleep 2s

Enable Python script to run on start up------------
DIR=/etc/init.d/S99RetroFlag
#sed '1,40 d' /etc/init.d/S99RetroFlag
#		chmod +x /userdata/RetroFlag/lcdfirst.sh
#		chmod +x /userdata/RetroFlag/lcdnext.sh

if grep -q "python $script &" "$DIR";
	then
		if [ -x $DIR ];
			then 
				echo "Executable S99RetroFlag already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo -e "python $script & \n sh /userdata/RetroFlag/lcdfirst.sh \n" >> $DIR 
#		echo -e "python $script & \n/userdata/RetroFlag/LCD.sh \n" >> $DIR 
#		echo "python $script &" >> $DIR
		chmod +x $DIR
#		chmod +x /userdata/RetroFlag/LCD.sh
		chmod +x /userdata/RetroFlag/lcdfirst.sh
		chmod +x /userdata/RetroFlag/lcdnext.sh
		echo "Executable S99RetroFlag configured."
fi
#-----------------------------------------------------------

#Step 5) Reboot to apply changes----------------------------
echo "RetroFlag Pi Case Switch installation done. Will now reboot after 3 seconds."
sleep 3
reboot
#-----------------------------------------------------------
