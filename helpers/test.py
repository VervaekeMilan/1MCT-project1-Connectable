import pygame
path = "music"
pygame.mixer.init()
#pygame.mixer.music.load(f"{path}/Black Horse and a Cherry Tree Lyrics ( 160kbps ).mp3")
pygame.mixer.music.load(path + "/Black Horse and a Cherry Tree Lyrics ( 160kbps ).mp3")
#pygame.mixer.music.load("music/John Denver _hearts_ Take Me Home, Country Roads  (The Ultimate Collection)  with Lyrics ( 160kbps ).mp3")
pygame.mixer.music.play()
while pygame.mixer.music.get_busy() == True:
    continue