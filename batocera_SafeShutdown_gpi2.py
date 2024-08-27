import os
from multiprocessing import Process
import RPi.GPIO as GPIO

# initialize pins


powerenPin = 27 
powerPin = 26 

#initialize GPIO settings
def init():
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(powerenPin, GPIO.OUT, initial=GPIO.HIGH)
	GPIO.setup(powerPin, GPIO.IN, initial=GPIO.HIGH)

#waits for user to hold button up to 1 second before issuing poweroff command
def poweroff():
	while True:
                GPIO.input(powerPin) == GPIO.HIGH:
		#	time.sleep(0.5)
		os.system("batocera-es-swissknife --emukill")
		time.sleep(1)
		os.system("shutdown -h now")
		
if __name__ == "__main__":
	#initialize GPIO settings
	init()
	#create a multiprocessing.Process instance for each function to enable parallelism 
	powerProcess = Process(target = poweroff)
	powerProcess.start()

	GPIO.cleanup()
