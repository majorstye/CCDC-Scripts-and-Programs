#!/bin/bash

# Update the system
sudo dnf update -y

# Install essential security tools
sudo dnf install -y fail2ban firewalld

# Enable and start the firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Configure the firewalld
sudo firewall-cmd --zone=public --add-service=ssh --permanent
# Add additional services as needed
# Example: sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload

# Install and configure fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Secure SSH configuration
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Disable unnecessary services
sudo systemctl disable bluetooth.service
sudo systemctl stop bluetooth.service

# Enable and configure automatic updates
sudo dnf install -y dnf-automatic
sudo systemctl enable dnf-automatic.timer
sudo systemctl start dnf-automatic.timer

# Remove unnecessary packages
# Example: sudo dnf remove -y package_name

# Enable SELinux
sudo setenforce 1
sudo sed -i 's/SELINUX=enforcing/SELINUX=enforcing/' /etc/selinux/config
