from time import sleep

from dynaconf import settings
from gpiozero import Device

import application.modules.soundplayer as player
from application.modules import slackpibot
from application.modules.gpio import buttons
from application.modules.gpio.constants import GPIO_PIN_17


def play_demo():
    if settings.DEMO_BUTTON_PRESS:
        # Get a reference to mock pin 16 (used by the button)
        sleep(1)
        _demo_button_press()

    if settings.DEMO_PLAY_OCTAVE:
        sleep(1)
        _demo_play_octave()

    if settings.DEMO_SLACK_MESSAGE:
        sleep(1)
        slackpibot.postMessage(settings.SLACK_HOME_CHANNEL, 'Hello world!')


def _demo_button_press():
    print('Emulate key down to button pinned at {}'.format(
        buttons[player.DO].pin))
    btn_pin = Device.pin_factory.pin(GPIO_PIN_17)
    btn_pin.drive_low()

def _demo_play_octave():
    print('Check sounds pinned at {}'.format(buttons[player.DO].pin))
    SLEEP = 0.5
    for note in player.sounds.keys():
        player.play_note(note)
        sleep(SLEEP)
