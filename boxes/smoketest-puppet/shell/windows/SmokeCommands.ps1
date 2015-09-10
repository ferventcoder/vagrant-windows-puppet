$env:PATH+=";$($env:SystemDrive)\Program Files (x86)\Puppet Labs\Puppet\bin;$($env:SystemDrive)\Program Files\Puppet Labs\Puppet\bin;"
$LogFile="$($env:SystemDrive)\SmokeTest.log"

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

"===============" | Out-File "$LogFile" -Force
"Versions"        | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
TimedCommand {puppet --version}
TimedCommand {facter --version}
TimedCommand {hiera --version}
TimedCommand {cmd /c "environment.bat && where ruby && ruby --version"}

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

"==============="  | Out-File "$LogFile" -Append
"Puppet Agent"     | Out-File "$LogFile" -Append
"==============="  | Out-File "$LogFile" -Append
TimedCommand {&net stop puppet}
TimedCommand {&net start puppet}
TimedCommand {puppet agent -t}

"===============" | Out-File "$LogFile" -Append
"Module Tests"    | Out-File "$LogFile" -Append
"===============" | Out-File "$LogFile" -Append
#TimedCommand {puppet module install chocolatey-chocolatey}
#TimedCommand {puppet apply --debug --verbose --trace c:\vagrant\puppet\agent\module_tests.pp}

$ModulesFolder = "$env:ProgramData\PuppetLabs\puppet\etc\modules"
TimedCommand {puppet module install puppetlabs-acl}
TimedCommand {puppet apply c:\vagrant\puppet\agent\acl_module_tests.pp}
TimedCommand {puppet apply c:\vagrant\puppet\agent\acl_module_tests.pp}
#Remove-Item "$ModulesFolder\acl" -Force

TimedCommand {&icacls c:\temp} -logOperationTime $false

TimedCommand {puppet module install puppetlabs-stdlib}
TimedCommand {puppet module install badgerious-windows_env}

TimedCommand {puppet module install puppetlabs-powershell}
TimedCommand {puppet apply c:\vagrant\puppet\agent\powershell_module_tests.pp}
#Remove-Item "$ModulesFolder\powershell" -Force

TimedCommand {puppet module install puppetlabs-registry}
TimedCommand {puppet apply c:\vagrant\puppet\agent\registry_module_tests.pp}
TimedCommand {puppet apply c:\vagrant\puppet\agent\registry_module_tests.pp}
#Remove-Item "$ModulesFolder\registry" -Force

TimedCommand {Get-ChildItem "hklm:\Software\Puppet Labs" | ForEach-Object {Get-ItemProperty $_.pspath} } -logOperationTime $false

TimedCommand {puppet module install puppetlabs-reboot}
TimedCommand {puppet apply c:\vagrant\puppet\agent\reboot_module_tests.pp}
#Remove-Item "$ModulesFolder\reboot" -Force
"Computer should now reboot" | Out-File "$LogFile" -Append
