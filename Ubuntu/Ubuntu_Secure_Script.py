import subprocess

# Update System
# On our Ubuntu Server, the following line returns an error saying the "run" attribute doesn't exist in module.
subprocess.run(['sudo', 'apt-get', 'update'], capture_output=True)
subprocess.run(['sudo', 'apt-get', 'upgrade'], capture_output=True)

# Configure firewall
subprocess.run(['sudo', 'ufw', 'default', 'deny', 'incoming'], capture_output=True)
subprocess.run(['sudo', 'ufw', 'default', 'allow', 'outgoing'], capture_output=True)
subprocess.run(['sudo', 'allow', 'ssh'], capture_output=True)
subprocess.run(['sudo', 'ufw', 'enable'], capture_output=True)

# Configure the password policies
subprocess.run(['sudo', 'authconfig', '--passminlen=14', '--update'], capture_output=True)
subprocess.run(['sudo', 'usermod', '--expiredate', '1', 'root'], capture_output=True)

# Disable the remote login
with open('/etc/ssh/sshd_config', 'r') as f:
    ssh_config = f.readlines()

with open('/etc/ssh/sshd_config', 'w') as f:
    for line in ssh_config:
        if 'PermitRootLogin' in line:
            f.write('PermitRootLogin no\n')
        else:
            f.write(line)

subprocess.run(['sudo', 'systemctl', 'reload', 'ssh'],capture_output=True)

# Enable automatic updates for security
subprocess.run(['sudo', 'apt-get', 'install', 'unattended-upgrades'], capture_output=True)
subprocess.run(['sudo', 'dpkg-reconfigure', 'unattended-ipgrades'], capture_output=True) 
