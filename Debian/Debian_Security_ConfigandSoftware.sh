# SSH Config
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config # Change SSH port (not required but may help secure)
sudo sed -i 's/#Permit RootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Disable root login
sudo systemctl restart sshd

# Install fail2ban for brute-force attacks
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Install and configure tripwire (IDS)
sudo apt install tripwire -y
# Configure as need be

# Install logwatch for log monitoring
sudo apt-get install -y logwatch
# Edit config as need be

# Harden against TCP/IP attacks
# net.ipv4.tcp_syncookies=1 | sudo tee -a /etc/sysctl.conf
# net.ipv4.conf.all.rp_filter=1 | sudo tee -a /etc/sysctl.conf
# net.ipv4.conf.all.accept_source_route=0 | sudo tee -a /etc/sysctl.conf
# sudo sysctl -p
