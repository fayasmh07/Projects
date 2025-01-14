# Define the output directory path
$outputpath = "C:\Users\metah\Programs\Securitylogs"

# Check if the output directory exists; if not, create it
if (-not (Test-Path -Path $outputpath)) {
    New-Item -ItemType Directory -Path $outputpath
}

# Get the current date in YYYYMMDD format for the filename
$currentdate = Get-Date -Format "yyyyMMdd"

# Define the start and end times for today
$starttime = (Get-Date).Date
$endtime = (Get-Date).Date.AddDays(1).AddSeconds(-1)

# Hashtable for filtering events
$filterHashtable = @{
    LogName   = "Security"
    ID        = 4624
    StartTime = $starttime
    EndTime   = $endtime
}

# Collect logs and store them in an XML file
$events = Get-WinEvent -FilterHashtable $filterHashtable
if ($events) {
    $events | Export-Clixml -Path "$outputpath\$currentdate-Securitylogs.xml"
    Write-Host "Security logs for successful logins on $currentdate have been collected and saved to: $outputpath" -ForegroundColor Green
} else {
    Write-Host "No security logs found for the date $currentdate" -ForegroundColor Red
}
