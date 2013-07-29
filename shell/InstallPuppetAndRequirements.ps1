$CommonAppDataPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::CommonApplicationData)
$PuppetAppDataPath = Join-Path $CommonAppDataPath 'PuppetLabs\puppet'

$env:PATH +=";$env:SystemDrive\Chocolatey\bin"
cinst puppet

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
    if (!$PuppetInstallPath.EndsWith($StatementTerminator)) {$PuppetInstallPath += $StatementTerminator}

    [Environment]::SetEnvironmentVariable('Path', $ActualPath + $PuppetInstallPath, [System.EnvironmentVariableTarget]::Machine)
}
$env:Path += ";$PuppetInstallPath"

if (!(Test-Path $PuppetAppDataPath)) {
  Write-Host "Creating folder `'$PuppetAppDataPath`'"
  $null = New-Item -Path "$PuppetAppDataPath" -ItemType Directory
}
Copy-Item "c:\vagrant\puppet\Puppetfile" "$PuppetAppDataPath"

cinst ruby -version 1.9.3.44800
Write-Host 'Attempting to add Ruby to the PATH'
$env:PATH +=";$env:SystemDrive\ruby193\bin"

Write-Host "Installing puppet librarian"
#& gem install puppet --no-ri --no-rdoc
& gem install librarian-puppet --no-ri --no-rdoc

Write-Host "Running librarian-puppet"
Push-Location "$PuppetAppDataPath"
& librarian-puppet install --clean
Pop-Location