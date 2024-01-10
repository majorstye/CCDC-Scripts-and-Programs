#!/bin/bash

#1. set up a strong password for the admin account
splunk edit user admin -password [NewPassword] -auth admin:changeme

#2. Enable SSL for the splunk web interface
splunk edit web-ssl enable -auth admin:changeme

#3. Configure the firewall rules to limit incoming connections to only necessary ports
iptables -A INPUT -p tcp --dport 8000 -j ACCEPT
iptables -A INPUT -p tcp --dport 9997 -j ACCEPT
iptables -A INPUT -p tcp --dport 8089 -j ACCEPT
iptables -A INPUT -j DROP

#4. Set up log monitoring to detect suspicious activity
splunk add monitor [LogPath] -auth admin:changeme

#5. Enable two-factor authentication
splunk add two-factor -type [TwoFactorType] -auth admin:changeme

#6. Regularly back up important splunk data
splunk backup [BackupDirectory] -auth admin:changeme

#7. Keep the splunk software and its components up tp date
splunk install [SoftwareUpdate.tgz] -auth admin:changeme
