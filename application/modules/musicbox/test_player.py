import os
from . import player

def test_setup():
  assert len(player.sounds) == 0
  player.setup(os.getcwd())
  assert len(player.sounds) == 7