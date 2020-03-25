
import application.modules.soundplayer as player


def setup_button_actions(buttons, sounds):
    for note in sounds.keys():
        if note in buttons.keys():
            print('Bind sound "{}" to button pinned at {}'.format(
                note, buttons[note].pin))
            buttons[note].when_pressed = sounds[note].play
