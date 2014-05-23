
$env:PATH+=";$($env:SystemDrive)\Program Files (x86)\Puppet Labs\Puppet\bin;$($env:SystemDrive)\Program Files\Puppet Labs\Puppet\bin;"

$LogFile="$($env:SystemDrive)\SmokeTest.log"

function TimedCommand {
param (
  [scriptblock]$command
)
"PS C:\>$command" | Out-File "$LogFile" -Append
$timer = [System.Diagnostics.Stopwatch]::StartNew()
Invoke-Command -ScriptBlock $command | Out-File "$LogFile" -Append
#Invoke-Expression -command $command.ToString() | Out-File "$LogFile" -Append
"---" | Out-File "$LogFile" -Append
">> Operation time for ($command): $($timer.Elapsed.ToString())" | Out-File "$LogFile" -Append
"---" | Out-File "$LogFile" -Append
"---------------" | Out-File "$LogFile" -Append
$timer.Stop | Out-Null
}

"===============" | Out-File "$LogFile" -Force
"Versions"        | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {puppet --version}
TimedCommand {facter --version}
TimedCommand {hiera --version}

"===============" | Out-File "$LogFile" -Append
"Help Commands"   | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {puppet help}
TimedCommand {puppet help apply}

"===============" | Out-File "$LogFile" -Append
"Resources"       | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {puppet resource user}
TimedCommand {puppet resource package --param provider}

"===============" | Out-File "$LogFile" -Append
"Puppet Apply"    | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {puppet apply -e "user {'Administrator': ensure=> present}"}
TimedCommand {puppet apply c:\vagrantshared\puppet\manifests\pup1389.pp}

"==============="  | Out-File "$LogFile" -Append
"Puppet Agent"     | Out-File "$LogFile" -Append
"==============="  | Out-File "$LogFile" -Append
TimedCommand {&net stop puppet}
TimedCommand {&net start puppet}
TimedCommand {puppet agent -t}
