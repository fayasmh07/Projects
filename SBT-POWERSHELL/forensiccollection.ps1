#This script collects information for Forensics Analysis from a Live WINDOWS SYSTEM icluding operating system info, users info, netwrok info, running processes and event logs.
#forensiccollection.ps1

#Collect System Information
Write-Output "Collecting System Information..."
$systeminfo = Get-ComputerInfo
$systeminfo | Out-File -FilePath "C:\Users\metah\Programs\systeminfo.txt" #You can change the folder and filename

#Collect User Information
Write-Output "Collecting User Information..."
$userinfo = Get-LocalUser
$userinfo | Out-File -FilePath "C:\Users\metah\Programs\userinfo.txt" #You can change the folder and filename

#Collect Network Information
Write-Output "Collecting Network Information..."
$networkinfo = Get-NetTCPConnection
$networkinfo | Out-File -FilePath "C:\Users\metah\Programs\networkinfo.txt" #You can change the folder and filename

#Collect Process Information
Write-Output "Collectin Process Information..."
$processinfo = Get-Process 
$processinfo | Out-File -FilePath "C:\Users\metah\Programs\processinfo.txt" #You can change the folder and filename

#Collecting Event Logs
Write-Output "Collecting Event Logs..."
$eventlogs = Get-EventLog -LogName System -Newest 100
$eventlogs | Out-File -FilePath "C:\Users\metah\Programs\eventlogs.txt" #You can change the folder and filename

