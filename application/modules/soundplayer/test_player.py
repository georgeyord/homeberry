import os
from application.modules.soundplayer.player import sounds, setup_notes

def test_setup():
  assert len(sounds) == 0
  setup_notes(os.getcwd())
  assert len(sounds) == 7