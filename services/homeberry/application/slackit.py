
import os
import socket

from application.modules import slackpibot
from dynaconf import settings


def _main():
    message = os.getenv('SLACKIT_MESSAGE')
    if message == None:
        message = 'Your RaspberryPi local IP is {}'.format(socket.gethostbyname(socket.gethostname()))

    print('Slack it message: {}'.format(message))
    slackpibot.postMessage(settings.SLACK_HOME_CHANNEL, message)


if __name__ == '__main__':
    _main()
