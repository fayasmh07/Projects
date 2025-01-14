#PowerShell script that automates collecting, parsing, and analyzing security logs from multiple sources. 
#The script will gather logs, extract relevant information, and generate a report highlighting potential security incidents. 
#   It will be similar to the previous labs in the course.

# Define the log sources to collect
$logSources = @(
    "System",
    "Application",
    "Security"
)

# Define the output directory for logs
$outputDir = "C:\SecurityLogs"
New-Item -ItemType Directory -Path $outputDir -Force

# Collect logs from each source
foreach ($source in $logSources) {
    $logs = Get-EventLog -LogName $source -Newest 1000
    $logs | Export-Csv -Path "$outputDir\$source.csv" -NoTypeInformation
}

# Collect Sysmon logs
$sysmonLogs = Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 1000
$sysmonLogs | Export-Csv -Path "$outputDir\Sysmon.csv" -NoTypeInformation

# Define a function to parse logs
function Parse-Log {
    param (
        [string]$logFile
    )
    
    $logData = Import-Csv -Path $logFile
    foreach ($entry in $logData) {
        $eventID = $entry.EventID
        $timeGenerated = $entry.TimeGenerated
        $message = $entry.Message
        
        Write-Output "EventID: $eventID, Time: $timeGenerated, Message: $message"
    }
}

# Define a function to analyze logs
function Analyze-Log {
    param (
        [string]$logFile
    )
    
    $logData = Import-Csv -Path $logFile
    foreach ($entry in $logData) {
        $eventID = $entry.EventID
        $timeGenerated = $entry.TimeGenerated
        $message = $entry.Message
        
        if ($eventID -in 4625, 4648, 4688, 4689, 4768) {
            Write-Output "Potential Security Incident: EventID $eventID at $timeGenerated - $message"
        }
    }
}

# Define a function to generate a report
function Generate-Report {
    param (
        [string]$reportFile
    )
    
    $html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Security Log Analysis Report</title>
</head>
<body>
    <h1>Security Log Analysis Report</h1>
    <table border="1">
        <tr>
            <th>EventID</th>
            <th>Time</th>
            <th>Message</th>
        </tr>
"@

    $logFiles = Get-ChildItem -Path $outputDir -Filter *.csv
    foreach ($logFile in $logFiles) {
        $logData = Import-Csv -Path $logFile.FullName
        foreach ($entry in $logData) {
            $eventID = $entry.EventID
            $timeGenerated = $entry.TimeGenerated
            $message = $entry.Message
            
            if ($eventID -in 4625, 4648, 4688, 4689, 4768) {
                $html += "<tr><td>$eventID</td><td>$timeGenerated</td><td>$message</td></tr>"
            }
        }
    }

    $html += @"
    </table>
</body>
</html>
"@

    $html | Out-File -FilePath $reportFile
}

# Parse and analyze each log file
$logFiles = Get-ChildItem -Path $outputDir -Filter *.csv
foreach ($logFile in $logFiles) {
    Parse-Log -logFile $logFile.FullName
    Analyze-Log -logFile $logFile.FullName
}

# Generate the report
$reportFile = "C:\SecurityLogs\AnalysisReport.html"
Generate-Report -reportFile $reportFile