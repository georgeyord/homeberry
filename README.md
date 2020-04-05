# homeberry

A Raspberry Pi project for Home automation

## Features

A home project, in Python, called Homeberry with multiple sub-features:

- MusicLock: A way to open a switch by playing the correct song in a keyboard
- Slack integration to send messages to a chat

Ansible playbooks to setup your Raspberry Pi in an organised way:

- RasberryPi common: to install some basic apps like curl, wget, jq, htop etc.
- Sync: to sync specific folders to Pi

## How to setup your Raspberry

> We assume you can login to your Pi using ssh and `~/.ssh/id_rsa` as sshkey

- Install `ansible`
- Go to `ansible` directory
- Create a file `hosts.ini`:
```

[all:vars]
ansible_ssh_private_key_file = ~/.ssh/id_rsa

[raspberrypi]
pi_one ansible_host=[YOUR_LAN_IP or raspberrypi.local] ansible_user=pi
```
- Run:
```
cd ansible
ansible-playbook raspberrypi.yaml
ansible-playbook byobu.yaml
ansible-playbook homeberry-prepare.yaml
```
- If the above fails due to invalid OS date, aka a message like the following:
```
is not valid yet (invalid for another 45d 9h 27min 56s). Updates for this repository will not be applied.
```
SSH login and update the machine's date using  this:
```
sudo date -s '9 Jul 2019 22:44
```
and re-run the `ansible-playbook` commands

## How to sync Homeberry code on your Raspberry

- Run:
```
cd ansible
ansible-playbook sync.yaml
```

## How to run services

### SlackIt!

- Run:
```
# To send the default message, the current IP to access Raspi:
make run-slackit

# To send a custom message:
SLACKIT_MESSAGE="A custom message!" make run-slackit
```

Enjoy!
