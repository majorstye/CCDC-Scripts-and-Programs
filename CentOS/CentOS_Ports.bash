#!/bin/bash

# This ads a new firewalld service for SSH
firewall-cmd --permanent --new-service=ssh

# This adds a rule to allow traffic on port 22 for the ssh service
firewall-cmd --permanent --service=ssh --add-port=22/tcp

# This adds arule to block traffic on port 22 for all other services
firewall-cmd --zone=publick --add-service=ssh --permanent
firewall-cmd --zone=public --remove-port=22/tcp --permanent

# This will reload the firewall config
firewall-cmd --reload
