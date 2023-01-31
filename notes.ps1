################################
# Foreach loop calling a function
$letterArray = "a","b","c","d"

function RunCommand {
  param (
    $ComputerName
)
  Write-Output $ComputerName, $ComputerName
}


foreach ($letter in $letterArray)
{
 RunCommand $letter
}


######################################
# Pasring exaple 1
# https://stackoverflow.com/questions/45357739/how-to-parse-pipe-cmd-line-output-using-powershell-to-an-object

$myExeOutput = & $myExe list
$myExeOutput |
    Where-Object {$_ -match 'Version:'} |
    ForEach-Object {
        $_ -replace '\s+Version:.*$',''
    }

######################################
# Parsing example 2

$String = @'
List of Runbook ID on the system: 



List of services installed on the system: 

ALMService   Version: 7.0.4542.16189
AOSService   Version: 7.0.4542.16189
BIService    Version: 7.0.4542.16189
DevToolsService  Version: 7.0.4542.16189
DIXFService  Version: 7.0.4542.16189
MROneBox     Version: 7.1.1541.3036
PayrollTaxModule     Version: 7.1.1541.3036
PerfSDK  Version: 7.0.4542.16189
ReportingService     Version: 7.0.4542.16189
RetailCloudPos   Version: 7.1.1541.3036
RetailHQConfiguration    Version: 7.1.1541.3036
RetailSDK    Version: 7.1.1541.3036
RetailSelfService    Version: 7.1.1541.3036
RetailServer     Version: 7.1.1541.3036
RetailStorefront     Version: 7.1.1541.3036
SCMSelfService   Version: 7.1.1541.3036
'@

$String -split '\r?\n' | Select-Object -Skip 6 | ForEach-Object {
    if ($_ -match '^\s*(?<Name>.+?)Version:\s*(?<Version>[\d.]+)\s*$') {
        [PSCustomObject]@{
            Name = $Matches['Name'].TrimEnd()
            Version = $Matches['Version']
        }
    }
    else {
        Write-Verbose -Verbose "Line didn't match. (Line: '$_')"
    }
}

###############################################33
# Run a cmd command and assign its output to variable?

$variable = cmd.exe /c "rd /s /q C:\#TEMP\test1"

# Can also use |
"notepad.exe" | cmd

# Can run multiple cmd commands on one line with &

# output to file
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.3
Get-Process | Out-File -FilePath .\Process.txt

# Append to file
"This is a test" >> Testfile.txt
# or
Add-Content C:\temp\test.txt "Test"

# new line =  `n 
Add-Content C:\temp\test.txt "`nThis is a new line"
