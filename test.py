from gpiozero import Button

btn = Button(17)

def hello():
  print("hello")


btn.when_pressed = hello

