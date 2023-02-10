# Diasable the unneeded services
Get-Service -DisplayName "Remote Registry" | Set-Service -StartupType Disabled
Get-service -DisplayName "server" | Set-Service -StartupType Disabled

# This will enable the firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enable True 

# This will enable auditing
Get-ExecutionPolicy -List | Set-ExecutionPolicy -ExecutionPolicy RemoteSign

# This will install windows def
Get-WindowsFeature -Name Windows-Defender | Install-WindowsFeature -IncludeManagementTools

# This will set a strong password ExecutionPolicy
$passwordPolicy = New-Object -TypeName System.DirectoryServices.AccountManagement.PasswordPolicy
$passwordPolicy.Length = 14
$passwordPolicy.Uppercase = 2
$passwordPolicy.Lowercase = 2
$passwordPolicy.NonAlpanumeric = 2
$passwordPolicy.Enabled = $true
$passwordPolicy.ExpirePasswordNow()

#This will enable SSL encryption
Import-Module IISAdministration
Get-childItem -Path IIS:\SslBindings | Where-Object { $_.IPAddress -eq "*" } | ForEach-Object { $_>AddSslCertificate("<CertificateThumbprint>", "<CertificateStore>") }
