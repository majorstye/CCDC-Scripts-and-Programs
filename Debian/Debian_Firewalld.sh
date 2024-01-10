#!/bin/bash

# Install firewalld
sudo apt-get update
sudo apt-get install -y firewalld

# Start firewalld service
sudo systemctl start firewalld

# Enable firewalld to start on boot
sudo systemctl enable firewalld

# Allow SSH, HTTP, and HTTPS traffic
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

# Reload firewall rules
sudo firewall-cmd --reload

# Check firewall status
sudo firewall-cmd --state
