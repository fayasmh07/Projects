#Script to analyze the security logs in XML format
#To count the number of successful logins in the security logs, you can use the following script:

# Define the directory containing the XML log files
$inputPath = "C:\\SecurityLogs"

# Verify the directory exists and contains XML files
if (-not (Test-Path -Path $inputPath)) {
    Write-Host "The specified input path does not exist." -ForegroundColor Red
    exit
}

$xmlFiles = Get-ChildItem -Path $inputPath -Filter "*.xml"
if ($xmlFiles.Count -eq 0) {
    Write-Host "No XML files found for analysis." -ForegroundColor Yellow
    exit
}

# Initialize a counter for successful logins
$successfulLoginCount = 0

foreach ($file in $xmlFiles) {
    [xml]$xmlContent = Get-Content -Path $file.FullName

# Count successful login events where Event ID is 4624
$successfulLoginCount += ($xmlContent.Objs.Obj | Where-Object { $_.Props.I32.N -eq "Id" -and $_.Props.I32."#text" -eq "4624" }).count


# Display the summary of successful logins
Write-Host "Total successful logins: $successfulLoginCount" -ForegroundColor Green