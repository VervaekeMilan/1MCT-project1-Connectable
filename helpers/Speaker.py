from RPi import GPIO
import pygame



class speaker:
    def __init__(self, enable):
        self.enable = enable
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(enable, GPIO.OUT)
        GPIO.output(enable, GPIO.LOW)
        self.path = "music"
        pygame.mixer.init()
        print("Speakers Initiated")

    def play_music(self):
        print("playing audio")
        pygame.mixer.music.load(self.path + "/Black Horse and a Cherry Tree Lyrics ( 160kbps ).mp3")
        pygame.mixer.music.play()
        while pygame.mixer.music.get_busy() == True:
            continue