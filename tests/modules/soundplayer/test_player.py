import os

from application.modules.soundplayer.player import setup_notes, sounds


def test_setup_notes():
    assert len(sounds) == 0
    setup_notes(os.getcwd())
    assert len(sounds) == 7
