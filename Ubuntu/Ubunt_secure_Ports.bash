#!/bin/bash

#1. Enable the firewall
ufw enable

#2. Allow incoming connections on necessary ports
ufw allow ssh
ufw allow http
ufw allow https

#3. Deny incomming connections on all other ports
ufw default deny incoming

#4. Allow outgoing connections on all ports
ufw default allow outgoing

#5. Enable logging of dropped packets
ufw logging on

#6. Verify the firewall status and config
ufw status verbose
