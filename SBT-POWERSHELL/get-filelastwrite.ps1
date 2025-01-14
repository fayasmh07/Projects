#Powershell for file dating

#Script to retrieve the last write time of files in a specified directory.
#Get-FileLastWrite.ps1

param(
    [string]$directory
)

Get-ChildItem -Path $directory -File | Select-Object FullName,LastWriteTime