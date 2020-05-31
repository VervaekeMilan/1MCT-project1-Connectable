from RPi import GPIO


class speaker:
    def __init__(self, enable):
        self.enable = enable
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(enable, GPIO.OUT)
        GPIO.output(enable, GPIO.LOW)
        print("Speakers Initiated")

