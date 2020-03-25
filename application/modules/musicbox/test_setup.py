
from application.modules.musicbox.setup import setup_button_actions
from application.modules.soundplayer import player
from gpiozero.pins.mock import MockFactory
from gpiozero import Device, Button, LED
from time import sleep

# Set the default pin factory to a mock factory
Device.pin_factory = MockFactory()

# Construct a couple of devices attached to mock pins 16 and 17, and link the
# devices
buttons = {
  player.DO: Button(16)
}

def test_setup_button_actions():
  assert buttons[player.DO].when_pressed is None
  setup_button_actions(buttons, player.sounds)
  # assert buttons[player.DO].when_pressed is function
  assert buttons[player.DO].is_active == False

  # Get a reference to mock pin 16 (used by the button)
  btn_pins = {
    player.DO: Device.pin_factory.pin(16)
  }

  btn_pins[player.DO].drive_low()
  sleep(0.1) # give source some time to re-read the button state
  assert buttons[player.DO].is_active
