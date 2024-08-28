import RPi.GPIO as GPIO
import os
import time
from multiprocessing import Process

powerPin = 26 
powerenPin = 27 

#initialize GPIO settings
def init():
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(powerPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
	GPIO.setup(powerenPin, GPIO.OUT, initial=GPIO.HIGH)
	GPIO.output(powerenPin, GPIO.HIGH)
	GPIO.setwarnings(False)

#waits for user to hold button up to 1 second before issuing poweroff command
def poweroff():
	while True:
		GPIO.wait_for_edge(powerPin, GPIO.FALLING)
		output = int(subprocess.check_output(['batocera-es-swissknife', '--espid']))
 		output_rc = int(subprocess.check_output(['batocera-es-swissknife', '--emupid']))
 		if output_rc:
			os.system("batocera-es-swissknife --emukill")
 		elif output:
			os.system("batocera-es-swissknife --shutdown")
		else:
			os.system("shutdown -r now")

if __name__ == "__main__":
	#initialize GPIO settings
	init()
	#create a multiprocessing.Process instance for each function to enable parallelism 
	powerProcess = Process(target = poweroff)
	powerProcess.start()


	powerProcess.join()

	GPIO.cleanup()
