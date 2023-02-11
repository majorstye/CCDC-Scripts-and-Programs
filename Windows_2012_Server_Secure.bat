@echo off
cls

rem #1. Enables the windows firewall
netsh advfirewall set allprofiles state on

rem #2. Disables the remote administration
reg add "HKLM\SYSTEM\CurrentsControlSet\Control\Terminal Server" /v fDenyTSConnections /t
REG_DWORD /d 1 /f

rem #3. Disables the remote desktop
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fAllowToGetHelp" /t
REG_DWORD /d 0 /f 

rem #4. Install Antivirus software and update its definitions (add your software)
start /wait msiexec /i [antivirusSoftware.msi] /qn
start /wait [AntivirusSoftwareUpdate.exe] /update

rem #5. Enables automatic updates
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v 
"AUOptions" /t REG_DWORD /d 4 /f 

rem #6. Implements a strong password policy
net accounts /minpwlen:14
net accounts /maxpwage:60

rem #7. Enable user account control
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentsVersion\Policies\System" /v "EnableLUA" /t 
REG_DWORD /d 1 /f 

rem #8. Disables unneeded services and features
dism.exe /Online /Disable-Feature /FeatureName:[UnneededFeature]

rem #9. Keeps the operating system and applications up to date
start /wait wuauclt.exe /detectnow