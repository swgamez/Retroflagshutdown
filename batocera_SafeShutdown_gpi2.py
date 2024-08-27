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

if __name__ == "__main__":
	#initialize GPIO settings
	init()
	#create a multiprocessing.Process instance for each function to enable parallelism 
	powerProcess = Process(target = poweroff)

	powerProcess.join()

	GPIO.cleanup()
