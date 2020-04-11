

import application.modules.soundplayer as player
from application.modules.demo import play_demo
from application.constants import ROOT_DIR
from application.modules.gpio import buttons, init_gpio_buttons
from application.modules.musicbox import setup_button_actions


def _init():
    init_gpio_buttons()
    player.setup_notes(ROOT_DIR)
    setup_button_actions(buttons, player.sounds)

def _main():
    # Play demo if enabled by configuration
    play_demo()


if __name__ == '__main__':
    try:
        _init()
        _main()
        # here you put your main loop
        # while True:
        #     _main()
        print("Main loop ended" )

    except KeyboardInterrupt:
        # here you put any code you want to run before the program
        # exits when you press CTRL+C
        print("Application interrupted, bye bye!" )

    except:
        # this catches ALL other exceptions including errors.
        # You won't get any error messages for debugging
        # so only use it once your code is working
        print("Application exception, bye bye!" )

    finally:
        GPIO.cleanup() # this ensures a clean exit