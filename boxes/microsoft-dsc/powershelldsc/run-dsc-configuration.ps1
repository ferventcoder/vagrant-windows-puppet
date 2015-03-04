$LogFile="$($env:SystemDrive)\StartDSCConfiguration_Times.log"

function TimedCommand {
param (
  [scriptblock]$command,
  [switch]$logOperationTime = $true
)
  $TempLogFile = $LogFile + "." + $(Get-Date).Ticks
  "PS C:\>$command" | Out-File "$LogFile" -Append
  $timer = [System.Diagnostics.Stopwatch]::StartNew()
  Invoke-Command -ScriptBlock $command | Tee -FilePath $TempLogFile
  $timeElapsed = $timer.Elapsed.ToString()
  $timer.Stop | Out-Null

  if (Test-Path $TempLogFile) {
    ForEach ($line in (Get-Content $TempLogFile)) {
      $line | Out-File "$LogFile" -Append
    }
    Remove-Item $TempLogFile -Force
  }

  #Invoke-Expression -command $command.ToString() | Out-File "$LogFile" -Append
  if ($logOperationTime) {
    "---" | Out-File "$LogFile" -Append
    ">> Operation time for ($command): $timeElapsed" | Out-File "$LogFile" -Append
    "---" | Out-File "$LogFile" -Append
    "---------------" | Out-File "$LogFile" -Append
  }
}

# reset
& .\Enable-LCM.ps1
$CimSession = New-CimSession -ComputerName localhost
Set-DscLocalConfigurationManager -Path .\Enabled -CimSession $CimSession
[Environment]::SetEnvironmentVariable('TestEnv', '', 'Machine')

# tests

$timer = [System.Diagnostics.Stopwatch]::StartNew()


Configuration PathUpdates {
  Node "localhost" {
    Environment TestPath {
      Ensure = "Present"
      Name = "TestEnv"
      Path = $false
      Value = "Test"
    }
  }
}

PathUpdates

#Compare-Dscconfiguration -Path .\PathUpdates
TimedCommand { Start-DscConfiguration -Wait -Verbose -Path .\PathUpdates }

$timeElapsed = $timer.Elapsed.ToString()
$timer.Stop | Out-Null

"===" | Out-File "$LogFile" -Append
" Operation time for Entire process: $timeElapsed" | Out-File "$LogFile" -Append
"===" | Out-File "$LogFile" -Append
