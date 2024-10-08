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

#waits for user to hold button up to 1 second before issuing poweroff command
def poweroff():
	while True:
		#self.assertEqual(GPIO.input(powerPin), GPIO.LOW)
		GPIO.wait_for_edge(powerPin, GPIO.FALLING)
		#start = time.time()
		#while GPIO.input(powerPin) == GPIO.HIGH:
		#	time.sleep(0.5)
		os.system("batocera-es-swissknife --emukill")
		time.sleep(0.5)
		os.system("shutdown -h now")

if __name__ == "__main__":
	#initialize GPIO settings
	init()
	#create a multiprocessing.Process instance for each function to enable parallelism 
	powerProcess = Process(target = poweroff)
	powerProcess.start()

	powerProcess.join()

	GPIO.cleanup()
