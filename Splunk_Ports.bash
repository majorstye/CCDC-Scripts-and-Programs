#!/bin/bash

# This adds a new firewalld service for Splunk
firewall-cmd --permanent --new-service=splunk

# This adds a rule to allow traffic on port 8089 for the splunk service
firewall-cmd --permanent --service=splunk --add-port=8089/tcp

# This adds a rule to block traffic on port 8089 for all other services
firewall-cmd --zone=public --add-service=splunk --permanent
firewall-cmd --zone=public --remove-port=8089/tcp --permanent

# This will reload the firewal config
firewall-cmd --reload

# Make sure to use firewalld on all othe linux machines