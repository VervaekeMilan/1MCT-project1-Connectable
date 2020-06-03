# pylint: skip-file
from repositories.DataRepository import DataRepository
from flask import Flask, jsonify
from flask_socketio import SocketIO
from flask_cors import CORS

import time
import threading

# Code voor led
from helpers.klasseknop import Button
from RPi import GPIO

from subprocess import check_output

from helpers.rotary_encoder import rotary_encoder
from helpers.Speaker import speaker
from helpers.relay import relay
from helpers.LCD import LCD
from helpers.hbridge import hbridge
from helpers.IR import IR
from helpers.IR import IR
# led1 = 21
# knop1 = Button(20)

###init_pins###

#rotary encoder
CLK = 20
DT = 21
rotary_encoder = rotary_encoder(CLK,DT)

#speaker
speaker_enable = 19
speaker = speaker(speaker_enable)

#cooler
relay_enable = 16
relay = relay(relay_enable)

#lcd
E = 24
RS = 25
SDA = 12
SCL = 23
address = 112
LCD = LCD(E, RS, SDA, SCL, address)

#H-Bridge
pin1 = 5
pin2 = 22
pin3 = 27
pin4 = 17
motor_enable = 6
hbridge = hbridge(motor_enable,pin1, pin2, pin3, pin4)

#IR
ir_signal = 13
IR = IR(ir_signal)


###variables###
counter = 6
clkLastState = 0

min_temp_cooler = 15
max_temp_cooler = 20
temp_check_freq = 10

is_cooler_open = False
cooler_moving_time = 10
power_signal_recieved = False
is_music_playing = False
buttons = {"power" : 1100000000111111111010001001011101, "vol_up" : 1100000000111111110110001010011101, "vol_down" : 1100000000111111111010100001010111, "open_cooler" : 1100000000111111111110000000011111, "close_cooler" : 1100000000111111111001000001101111, "0" : 1100000000111111110110100010010111} #0 is speakers

devices = {relay_enable : "cooler", speaker_enable : "speakers"}

#temp file
sensor_file_name = '/sys/bus/w1/devices/28-03079779a2f9/w1_slave'

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
# GPIO.setup(led1, GPIO.OUT)

###end_init_pins###

app = Flask(__name__)
app.config['SECRET_KEY'] = 'Hier mag je om het even wat schrijven, zolang het maar geheim blijft en een string is'

socketio = SocketIO(app, cors_allowed_origins="*")
CORS(app)


# API ENDPOINTS
@app.route('/')
def hallo():
    return "Server is running, er zijn momenteel geen API endpoints beschikbaar."


# SOCKET IO
@socketio.on('connect')
def initial_connection():
    print('A new client connect')
    # # Send to the client!
    # vraag de status op van de lampen uit de DB
    status = DataRepository.read_status_lampen()
    socketio.emit('B2F_status_lampen', {'lampen': status})


@socketio.on('F2B_switch_light')
def switch_light(data):
    print('licht gaat aan/uit')
    lamp_id = data['lamp_id']
    new_status = data['new_status']
    # spreek de hardware aan
    # stel de status in op de DB
    res = DataRepository.update_status_lamp(lamp_id, new_status)
    print(lamp_id)
    if lamp_id == "2":
        lees_knop(20)
    # vraag de (nieuwe) status op van de lamp
    data = DataRepository.read_status_lamp_by_id(lamp_id)
    socketio.emit('B2F_verandering_lamp', {'lamp': data})


# def lees_knop(pin):
#     print("button pressed")
#     if GPIO.input(led1) == 1:
#         GPIO.output(led1, GPIO.LOW)
#         res = DataRepository.update_status_lamp("2", "0")
#     else:
#         GPIO.output(led1, GPIO.HIGH)
#         res = DataRepository.update_status_lamp("2", "1")
#     data = DataRepository.read_status_lamp_by_id("2")
#     socketio.emit('B2F_verandering_lamp', {'lamp': data})

@socketio.on('B2F_update_counter')
#rotary encoder
def update_counter(CLK):
    global clkLastState
    global counter
    DT_state = GPIO.input(CLK)
    CLK_state = GPIO.input(DT)
    if CLK_state != clkLastState:
        if DT_state == 1:
            if counter != 10:
                counter = counter + 1
        else:
            if counter != 0:
                counter = counter - 1
        #print(counter)
    CLK_state = clkLastState
    speaker.change_volume(counter)

def enable_device(pin):
    print(f"Enabling {devices[pin]}")
    GPIO.output(pin, GPIO.HIGH)

def disable_device(pin):
    print(f"Disabling {devices[pin]}")
    GPIO.output(pin, GPIO.LOW)

def check_temp():
    while True:
        print("Checking Temperature")
        sensor_file = open(sensor_file_name, 'r')
        for line in sensor_file:
            pos = line.find('t')
            if pos != -1:
                temp = (float(line[pos+2:]))/1000
                print(f"It's {temp} degrees celsius")
                if temp <= min_temp_cooler :
                    #print(f"It's {temp} degrees celsius")
                    disable_device(relay_enable)
                    
                if temp >= max_temp_cooler and is_cooler_open == False:
                    #print(f"It's {temp} degrees celsius")
                    enable_device(relay_enable)
                    
        sensor_file.close()
        time.sleep(temp_check_freq)

def find_ip():
    ip = str(check_output(['hostname', '--all-ip-addresses']))
    index = ip.find(' ')
    ip = (ip[2:index])
    LCD.write_message(ip)
    print("IP visible")

def close_cooler(): #anti-clockwise
    global is_cooler_open
    if is_cooler_open == True:
        print("closing cooler")
        GPIO.output(pin1,GPIO.HIGH)
        GPIO.output(pin3,GPIO.HIGH)
        GPIO.output(pin2,GPIO.LOW)
        GPIO.output(pin4,GPIO.LOW)
        time.sleep(cooler_moving_time)
        stop_moving_cooler()
        #threading.Timer(cooler_moving_time, stop_moving_cooler)
        is_cooler_open = False
    else: 
        print("cooler is already closed")

def open_cooler(): #clockwise
    global is_cooler_open
    if is_cooler_open == False:
        disable_device(relay_enable)
        is_cooler_open = True
        print("opening cooler")
        GPIO.output(pin2,GPIO.HIGH)
        GPIO.output(pin4,GPIO.HIGH)
        GPIO.output(pin1,GPIO.LOW)
        GPIO.output(pin3,GPIO.LOW)
        time.sleep(cooler_moving_time)
        stop_moving_cooler()
        #threading.Timer(cooler_moving_time, stop_moving_cooler)
    else: 
        print("cooler is already open")

def stop_moving_cooler():
    print("pausing cooler movement")
    GPIO.output(pin1,GPIO.HIGH)
    GPIO.output(pin2,GPIO.HIGH)
    GPIO.output(pin3,GPIO.HIGH)
    GPIO.output(pin4,GPIO.HIGH)

def decode_IR_signal(ir_signal):
    print("decoding IR signal")
    binary = IR.get_binary()
    code = binary
    print(binary)
    global power_signal_recieved
    if power_signal_recieved == True:
       
        if (binary == buttons["0"]):
            global is_music_playing
            if is_music_playing == False:
                enable_device(speaker_enable)
                threading.Thread(target=speaker.play_music())
                is_music_playing == True
                power_signal_recieved == False
            else:
                threading.Thread(target=speaker.stop_music())
                is_music_playing = False
                power_signal_recieved == False
                
    if(binary == buttons["open_cooler"]):
        threading.Thread(target=open_cooler())

    elif(binary == buttons["close_cooler"]):
        threading.Thread(target=close_cooler())
    elif (binary == buttons["power"]):
        power_signal_recieved = True
         print("power_signal_recieved press a num button to enable or disable a device")
    else: 
        print("wrong code")
# def activate_speakers():
#     enable_device(speaker_enable)
#     speaker.play_music()


# knop1.on_press(lees_knop)

find_ip()
IR.on_ir_receive(decode_IR_signal)
rotary_encoder.on_turn(update_counter)


threading.Thread(target=check_temp()).start



if __name__ == '__main__':
    socketio.run(app, debug=False, host='0.0.0.0')
