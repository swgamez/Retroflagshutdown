import os
import time
from multiprocessing import Process

import RPi.GPIO as GPIO

# initialize pins
powerPin = 26
powerenPin = 27


def init():
    # initialize GPIO settings
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(powerPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(powerenPin, GPIO.OUT)
    GPIO.output(powerenPin, GPIO.HIGH)


def poweroff():
    while True:
        GPIO.wait_for_edge(powerPin, GPIO.FALLING)
        # Wait 15 seconds (extra margin) and see if pin is still LOW
        # If it's still LOW, it must be the power switch that toggled
        time.sleep(15)
        if not GPIO.input(powerPin):
            os.system("poweroff")


if __name__ == "__main__":
    # initialize GPIO settings
    init()
    # create a multiprocessing.Process instance for each function to enable parallelism
    powerProcess = Process(target=poweroff)
    powerProcess.start()

    powerProcess.join()

    GPIO.cleanup()
