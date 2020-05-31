#IP adres vinden en afdrukken op het LCD display (RS gpio 25, E gpio 24, SDA gpio 12, SCL gpio 23)
from RPi import GPIO
import time

instructions = {"display_on" : 0b00001100, "function_set" : 0b00111000,"clear_display" : 0b00000001}

class LCD:
    def __init__(self, E, RS, SDA, SCL, address):
        self.E = E
        self.RS = RS
        self.SDA = SDA
        self.SCL = SCL
        self.address = address

        GPIO.setmode(GPIO.BCM)
        GPIO.setup(RS,GPIO.OUT)
        GPIO.setup(E,GPIO.OUT)
        GPIO.output(E,GPIO.HIGH)
        GPIO.setup(SDA,GPIO.OUT)
        GPIO.setup(SCL,GPIO.OUT)
        GPIO.output(SDA,GPIO.HIGH)
        GPIO.output(SCL,GPIO.HIGH)
        
        self.send_instruction(instructions["function_set"])
        self.send_instruction(instructions["display_on"])
        self.send_instruction(instructions["clear_display"])
        print("LCD initiated")

    def send_instruction(self, value):
        GPIO.output(self.RS,GPIO.LOW)
        self.set_data_bits(value)

    def start_condition(self):
        GPIO.output(self.SDA,GPIO.LOW)
        time.sleep(0.002)
        GPIO.output(self.SCL,GPIO.LOW)
          

    def stop_conditie(self):
        GPIO.output(self.SCL,GPIO.HIGH)
        time.sleep(0.002)
        GPIO.output(self.SDA,GPIO.HIGH)

    def adres(self):
        self.writebyte(self.address)

    def writebyte(self, byte):
        mask = 0x80
        for i in range(0, 8):
            bit = mask & byte
            bit = bit >> 7 - i
            self.writebit(bit)
            mask = mask >> 1

    def writebit(self, bit):
        if bit == True:
            GPIO.output(self.SDA,GPIO.HIGH)
   
            GPIO.output(self.SCL,GPIO.HIGH)
            time.sleep(0.001)
            GPIO.output(self.SCL,GPIO.LOW)
        elif bit == False:
            GPIO.output(self.SDA,GPIO.LOW)
  
            GPIO.output(self.SCL,GPIO.HIGH)
            time.sleep(0.001)
            GPIO.output(self.SCL,GPIO.LOW)

    def ack(self):
        GPIO.setup(self.SDA,GPIO.IN, pull_up_down=GPIO.PUD_UP)
        GPIO.output(self.SCL,GPIO.HIGH)

        status = GPIO.input(self.SDA)

        GPIO.setup(self.SDA,GPIO.OUT)
        GPIO.output(self.SCL,GPIO.LOW)


    def write_message(self, message):
        message = str(message)
        aantal = len(message)
        self.send_instruction(instructions["clear_display"])
        for i in range(0, aantal):
            self.send_character(ord(message[i]))
  
    def send_character(self, value):
        GPIO.output(self.RS,GPIO.HIGH)
        self.set_data_bits(value)

    def set_data_bits(self, value):
        self.start_condition()
        self.adres()
        self.ack()
        mask = 0x80
        for i in range(0, 8):
            bit = value & mask
            bit = bit >> 7 - i
            if bit == 1:
                self.writebit(True)
            elif bit == 0:
                self.writebit(False)
            mask = mask >> 1
        self.ack()
        self.stop_conditie()
        GPIO.output(self.E,GPIO.LOW)
        time.sleep(0.01)
        GPIO.output(self.E,GPIO.HIGH)