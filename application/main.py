import os
from application.modules.soundplayer import player
from application.modules.musicbox.setup import setup_button_actions
from .gpio import init_gpio_buttons, buttons

def main():
    init_gpio_buttons()
    setup_button_actions(buttons, player.sounds)

    root_dir = os.getcwd()
    player.setup_notes(root_dir)
    player.play_note('do')


if __name__ == '__main__':
    main()
