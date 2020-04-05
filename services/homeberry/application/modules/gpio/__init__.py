
from dynaconf import settings
from gpiozero import Button, Device
from gpiozero.pins.mock import MockFactory

import application.modules.soundplayer as player
from application.modules.gpio.constants import GPIO_PIN_17

# Globals
buttons = {}

if settings.MOCKED_GPIO:
    print('Use MockFactory as GPIO Pin factory')
    Device.pin_factory = MockFactory()


def init_gpio_buttons():
    buttons[player.DO] = Button(GPIO_PIN_17)
