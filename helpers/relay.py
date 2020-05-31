#als de temperatuur in de koeler stijgt tot boven ene bepaalde waarde, schakelt de transistor (gpio 16)

from RPi import GPIO


class relay:
    def __init__(self, enable):
        self.enable = enable
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(enable, GPIO.OUT)
        GPIO.output(enable, GPIO.LOW)
        print("Relay Initiated")