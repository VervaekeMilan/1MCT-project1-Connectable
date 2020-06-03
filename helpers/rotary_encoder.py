from RPi import GPIO


class rotary_encoder:
    def __init__(self, CLK, DT):
        self.CLK = CLK
        self.DT = DT

        GPIO.setmode(GPIO.BCM)
        GPIO.setup(CLK,GPIO.IN,pull_up_down=GPIO.PUD_UP)
        GPIO.setup(DT,GPIO.IN,pull_up_down=GPIO.PUD_UP)
        print("Rotary Encoder Initiated")

    def on_turn(self, callback):
        print("Rotary Encoder call detection")
        GPIO.add_event_detect(self.CLK, GPIO.FALLING, callback, bouncetime=1)

    