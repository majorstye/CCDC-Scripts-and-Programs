# Message of the Day Script
# Author: IJ
# 1/23/024

# Set the welcom message variable:
$newLegalNoticeCaption = "NOTICE:"
$newLegalNoticeText = "Unauthorized access is strictly prohibited. All activities on this machine are monitored and recorded. If you are not an authorized user, disconnect immediately. Unauthorized access may result in legal action. By continuing, you consent to these terms."

# Set registry path for the welcome message
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# Set the registry value name
$captionValueName = "LegalNoticeCaption"
$textValueName = "LegalNoticeText"

# Backup the existing welcome message
#try {
#    $currentWelcomeMessage = Get-ItemProperty -Path $registryPath -Name $valueName
#    $currentWelcomeMessage | Out-File "C:\Backup\WelcomeMessageBackup.txt"
#    Write-Host "Backup of the existing welcome message has been created."
#} catch {
#    Write-Host "No existing welcome message found. No backup created."
#}

# Set the new welcome message
New-Item -Path $registryPath -Force
Set-ItemProperty -Path $registryPath -Name $captionValueName -Value $newLegalNoticeCaption
Set-ItemProperty -Path $registryPath -Name $textValueName -Value $newLegalNoticeText

Write-Host "Welcome message has been updated to:"
Get-ItemProperty -Path $registryPath -Name $captionValueName | Select-Object -ExpandProperty $captionValueName
Get-ItemProperty -Path $registryPath -Name $textValueName | Select-Object -ExpandProperty $textValueName
