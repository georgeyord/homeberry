import os

import modules.musicbox.player as player


def main():
    root_dir = os.getcwd()
    player.setup(root_dir)
    player.play_note('do')


if __name__ == '__main__':
    main()
