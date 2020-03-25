

import application.modules.soundplayer as player
from application.modules.demo import play_demo
from application.constants import ROOT_DIR
from application.modules.gpio import buttons, init_gpio_buttons
from application.modules.musicbox import setup_button_actions


def _main():
    init_gpio_buttons()
    player.setup_notes(ROOT_DIR)
    setup_button_actions(buttons, player.sounds)

    # Play demo if enabled by configuration
    play_demo()


if __name__ == '__main__':
    _main()
