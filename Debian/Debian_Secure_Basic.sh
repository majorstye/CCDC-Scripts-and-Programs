#!/bin/bash

# Update package list / upgrade installed packages
sudo apt-get update
sudo apt-get upgrade

# Make sure firewalld is running
sudo systemctl start firewalld

# Disable root login via ssh
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh restart

# Limit user login attempts
sudo sed -i '/pam_unix.so/s/$/ deny=5/' /etc/pam.d/common-auth

# Set file permissions and ownership for important/sensitive files
# Add/remove as need be
sudo chmod 644 /etc/passwd
sudo chmod 600 /etc/shadow

# Uncomment if needed, need to test
# Harden network parameters (Edit /etc/sysctl.conf)
# sudo tee -a /etc/sysctl.conf >/dev/null <<EOT
# Disable IPv6
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.default.disable_ipv6 = 1
# EOT
# sudo sysctl -p

# Disable unnecessary services
# Replace <service_name> with name of service 
sudo systemctl disable <service_name>

# Check for open ports
sudo netstat -tuln

# Check for listening services
sudo ss -tulw
