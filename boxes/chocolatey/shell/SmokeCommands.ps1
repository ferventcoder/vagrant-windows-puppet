$env:PATH+=";$($env:SystemDrive)\Chocolatey\bin;$($env:SystemDrive)\ProgramData\Chocolatey\bin;"
$LogFile="$($env:SystemDrive)\ChocolateySmokeTests.log"

Set-ExecutionPolicy Unrestricted
$DebugPreference = "Continue";
$env:ChocolateyEnvironmentDebug = 'true'

function TimedCommand {
param (
  [scriptblock]$command
)
  "PS C:\>$command" | Out-File "$LogFile" -Append
  $timer = [System.Diagnostics.Stopwatch]::StartNew()
  Invoke-Command -ScriptBlock $command | Out-File "$LogFile" -Append
  # foreach ($line in $output) {
  #   $line | Out-File "$LogFile" -Append
  # }

  "---" | Out-File "$LogFile" -Append
  ">> Operation time for ($command): $($timer.Elapsed.ToString())" | Out-File "$LogFile" -Append
  "---------------" | Out-File "$LogFile" -Append
  $timer.Stop | Out-Null
}

"===============" | Out-File "$LogFile" -Force
"Install"         | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand { & C:\vagrant\shell\InstallChocolatey.ps1 }

"===============" | Out-File "$LogFile" -Append
"Short Commands"  | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {choco -help}
TimedCommand {choco list -lo}
TimedCommand {choco}

#Install - installer package


#Install - zip package


# Ensure item is on path
#Upgrade package

