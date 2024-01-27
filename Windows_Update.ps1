# Must be admin to run windows update.

# Installs Powershell Windows Update Module
Install-Module PSWindowsUpdate

# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate

# Views available updates
#Get-WindowsUpdate

# Install all cumulative updates.
#Install-WindowsUpdate

# The following update will download install, and reboot Windows 10
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
