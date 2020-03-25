from time import sleep

from gpiozero import Device

import application.modules.soundplayer as player
from application.constants import ROOT_DIR
from application.modules.gpio import buttons, init_gpio_buttons
from application.modules.gpio.constants import GPIO_PIN_17
from application.modules.musicbox import setup_button_actions


def _main():
    init_gpio_buttons()
    player.setup_notes(ROOT_DIR)
    setup_button_actions(buttons, player.sounds)

    # Get a reference to mock pin 16 (used by the button)
    sleep(1)
    print('Emulate key down to button pinned at {}'.format(
        buttons[player.DO].pin))
    btn_pin = Device.pin_factory.pin(GPIO_PIN_17)
    btn_pin.drive_low()

    sleep(2)
    print('Check sounds pinned at {}'.format(buttons[player.DO].pin))
    SLEEP = 0.5
    for note in player.sounds.keys():
        player.play_note(note)
        sleep(SLEEP)


if __name__ == '__main__':
    _main()
