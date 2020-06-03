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
        self.volume = pygame.mixer.music.get_volume()
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

    def stop_music():
        pygame.mixer.music.stop()

    def choose_track(self):
        self.rand_song = self.path + "/" + random.choice(os.listdir('music'))

    def pause(self):
        if self.paused == False:
            pygame.mixer.music.pause(self.rand_song)
        else:
           pygame.mixer.music.unpause(self.rand_song)

    @staticmethod
    def change_volume(counter):
        pygame.mixer.music.set_volume(counter/10)
        print(f"volume changed to {counter}/10")
