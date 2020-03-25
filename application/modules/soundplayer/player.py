import os
import pygame

from . import sounds

DO = 'do'
RE = 're'
MI = 'mi'
FA = 'fa'
SOL = 'sol'
LA = 'la'
SI = 'si'

NOTES = [DO, RE, MI, FA, SOL, LA, SI]

pygame.init()


sounds = {}


def setup_notes(root_dir):
    # Iterating using for loop
    for note in NOTES:
        path = '{}/application/modules/soundplayer/sounds/piano-{}.wav'.format(
            root_dir, note)
        # print('{}@{}'.format(note, path))
        sound = pygame.mixer.Sound(path)
        sounds[note] = sound


def play_note(note):
    print('Note: {}'.format(note))
    sounds[note].play()
