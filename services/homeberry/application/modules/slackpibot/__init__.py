import slack
from dynaconf import settings

_client = slack.WebClient(token=settings.SLACK_API_TOKEN)

def postMessage(channel, text):
    return _client.chat_postMessage(channel=channel, text=text)
    # assert response["ok"]
    # assert response["message"]["text"] == "Hello world!"
