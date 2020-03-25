
from application.modules.soundplayer import player

def setup_button_actions(buttons, sounds):
    for note, sound in sounds:
      if note in buttons.keys():
        print('Bind sound to button press')
        buttons[note].when_pressed = sound.play
