$PuppetInstallPath = "$env:SystemDrive\Program Files (x86)\Puppet Labs\Puppet\bin"
if (!(Test-Path $PuppetInstallPath)) {$PuppetInstallPath = "$env:SystemDrive\Program Files\Puppet Labs\Puppet\bin";}

$env:Path += ";$PuppetInstallPath"

$CommonAppDataPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::CommonApplicationData)
$PuppetAppDataPath = Join-Path $CommonAppDataPath 'PuppetLabs\puppet'
$PuppetEtcPath = Join-Path "$PuppetAppDataPath" 'etc'

if (!(Test-Path $PuppetEtcPath)) {
  Write-Host "Creating folder `'$PuppetEtcPath`'"
  $null = New-Item -Path "$PuppetEtcPath" -ItemType Directory
}

Copy-Item "c:\vagrant\puppet\Puppetfile" "$PuppetEtcPath"

Push-Location "$PuppetEtcPath"
Write-Host "Ensuring librarian puppet"
try {
    $ErrorActionPreference = "Stop";
    Get-Command librarian-puppet
    Write-Host "Running librarian-puppet update"
    & librarian-puppet update
} catch {
    Write-Host "Installing librarian puppet"
    & gem install librarian-puppet --no-ri --no-rdoc
    Write-Host "Running librarian-puppet install --clean"

    & librarian-puppet install --clean
} finally {
    $ErrorActionPreference = "Continue";
    Pop-Location
}
