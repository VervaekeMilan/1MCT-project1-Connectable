from RPi import GPIO
from datetime import datetime

class IR:
    def __init__(self, pin):
        self.pin = pin
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin, GPIO.IN, GPIO.PUD_DOWN)

    def on_ir_receive(self, call_method):
        print("IR call detection")
        GPIO.add_event_detect(self.pin, GPIO.FALLING, callback= call_method, bouncetime=150)


    def get_binary(self):
        print("fetching IR code")
        consecutive_ones = 0
        binary = 1
        code = []
        previous_value = 0
        value = GPIO.input(self.pin)

        while value:
            value = GPIO.input(self.pin)

        start_time = datetime.now()

        while True :
            if previous_value != value:
                now = datetime.now()
                pulse_time = now - start_time
                start_time = now
                code.append((previous_value, pulse_time.microseconds))

            if value == True: 
                consecutive_ones += 1
            else: 
                consecutive_ones = 0
            if consecutive_ones > 10000: 
                break

            previous_value = value
            value = GPIO.input(self.pin)

        for (value, time) in code:
            if value == 1:
                if time > 1000 : binary = binary *10 +1
                else: binary *= 10

        if len(str(binary)) > 34:
            binary = int(str(binary)[:34])

        return binary
