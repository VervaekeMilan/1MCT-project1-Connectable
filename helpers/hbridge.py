from RPi import GPIO

class hbridge:
    def __init__(self, motor_enable, pin1, pin2, pin3, pin4):
        self.pin1 = pin1
        self.pin2 = pin2
        self.pin3 = pin3
        self.pin4 = pin4
        self.motor_enable = motor_enable

        GPIO.setup(pin1,GPIO.OUT)
        GPIO.setup(pin2,GPIO.OUT)
        GPIO.setup(pin3,GPIO.OUT)
        GPIO.setup(pin4,GPIO.OUT)
        GPIO.setup(motor_enable,GPIO.OUT)
        
        GPIO.output(pin1,GPIO.HIGH)
        GPIO.output(pin2,GPIO.HIGH)
        GPIO.output(pin3,GPIO.HIGH)
        GPIO.output(pin4,GPIO.HIGH)
        
        GPIO.output(motor_enable,GPIO.HIGH)
        print("Motor Cooler Initiated")