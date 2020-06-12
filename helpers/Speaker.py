from RPi import GPIO
import pygame
import os, random


class speaker:
    def __init__(self, enable):
        self.enable = enable
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(enable, GPIO.OUT)
        GPIO.output(enable, GPIO.LOW)
        pygame.mixer.init()
        self.path = "music"
        self.paused = False
        self.rand_song = ""
        self.volume = pygame.mixer.music.set_volume(0.1)
        print("Speakers Initiated")

    def play_music(self):
        print("Playing Audio")
        self.choose_track()
        print(f"Playing {self.rand_song}")
        pygame.mixer.music.load(self.rand_song)
        pygame.mixer.music.play()
        while pygame.mixer.music.get_busy() == True:
            continue
        if pygame.mixer.music.get_busy() == False:
            self.play_music()


    def stop_music(self):
        pygame.mixer.music.stop()

    def choose_track(self):
        self.rand_song = self.path + "/" + random.choice(os.listdir('/home/pi/project1/music'))
    
    def pause(self):
        if self.paused == False:
            pygame.mixer.music.pause()
        else:
           pygame.mixer.music.unpause()

    @staticmethod
    def change_volume(counter, max_volume):
        pygame.mixer.music.set_volume(counter/max_volume)
        print(f"volume changed to {counter}/{str(max_volume)}")
