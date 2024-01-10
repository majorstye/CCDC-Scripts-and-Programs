#!/bin/bash

# Store the list of members of the sudo group in an array
admins=($(getnet group sudo | cut -d: -f4 | tr '.' '\n'))

# Prints a message
echo "List of Users with Administrative Rights on Ubuntu:"

# Loop that goes through the array of admins
for username in "${admins[@]}"; do
  # Prints the username
  echo " - $username"
done
