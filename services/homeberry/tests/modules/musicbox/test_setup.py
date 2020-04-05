
from time import sleep

from gpiozero import LED, Button, Device
from gpiozero.pins.mock import MockFactory

import application.modules.soundplayer as player
from application.modules.gpio.constants import GPIO_PIN_17
from application.modules.musicbox import setup_button_actions

# Set the default pin factory to a mock factory
Device.pin_factory = MockFactory()


def test_setup_button_actions():
    # Construct a couple of devices attached to mock pins
    buttons = {
        player.DO: Button(GPIO_PIN_17)
    }

    assert buttons[player.DO].when_pressed is None
    setup_button_actions(buttons, player.sounds)
    # assert buttons[player.DO].when_pressed is function
    assert buttons[player.DO].is_active == False

    # Get a reference to mock pin 16 (used by the button)
    btn_pins = {
        player.DO: Device.pin_factory.pin(GPIO_PIN_17)
    }

    btn_pins[player.DO].drive_low()
    sleep(0.2)  # give source some time to re-read the button state
    assert buttons[player.DO].is_active
