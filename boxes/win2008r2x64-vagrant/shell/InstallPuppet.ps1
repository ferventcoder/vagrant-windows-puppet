$env:PATH +=";$env:SystemDrive\Chocolatey\bin"

# cinst ruby -version 1.9.3.44800
# Write-Host 'Attempting to add Ruby to the PATH'
# $env:PATH +=";$env:SystemDrive\ruby193\bin"

# Write-Host "Ensuring puppet"
# try {
#     $ErrorActionPreference = "Stop";
#     Get-Command puppet
# } catch {
#     Write-Host "Installing puppet"
#     & gem install puppet --no-ri --no-rdoc
# } finally {
#     $ErrorActionPreference = "Continue";
# }

cinst puppet -source 'c:\vagrant\resources'

$PuppetInstallPath = "$env:SystemDrive\Program Files (x86)\Puppet Labs\Puppet\bin"
if (!(Test-Path $PuppetInstallPath)) {$PuppetInstallPath = "$env:SystemDrive\Program Files\Puppet Labs\Puppet\bin";}

#get the PATH variable
$envPath = $env:PATH
if (!$envPath.ToLower().Contains($PuppetInstallPath.ToLower())) {
    Write-Host "PATH environment variable does not have `'$PuppetInstallPath`' in it. Adding..."
    $ActualPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
    $StatementTerminator = ";"
    $HasStatementTerminator = $ActualPath -ne $null -and $ActualPath.EndsWith($StatementTerminator)
    If (!$HasStatementTerminator -and $ActualPath -ne $null) {$PuppetInstallPath = $StatementTerminator + $PuppetInstallPath}

    [Environment]::SetEnvironmentVariable('Path', $ActualPath + $PuppetInstallPath, [System.EnvironmentVariableTarget]::Machine)
}