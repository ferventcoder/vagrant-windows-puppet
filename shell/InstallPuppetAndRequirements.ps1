cinst ruby -version 1.9.3.44800 -force

$Common_AppData = [Environment]::GetFolderPath([Environment+SpecialFolder]::CommonApplicationData)

$Puppet_Dir = Join-Path $Common_AppData 'PuppetLabs\puppet'

if (!(Test-Path $Puppet_Dir)) {
  Write-Host "Creating folder `'$Puppet_Dir`'"
  $null = New-Item -Path "$Puppet_Dir" -ItemType Directory
}

Copy-Item "c:\vagrant\puppet\Puppetfile" "$Puppet_Dir"

Write-Host 'Attempting to add Ruby to the PATH'
$env:PATH="$env:PATH;c:\ruby193\bin"

Write-Host "Installing puppet and puppet librarian"
& gem install puppet --no-ri --no-rdoc
& gem install librarian-puppet --no-ri --no-rdoc

Write-Host "Running librarian-puppet"
Push-Location "$Puppet_Dir"
& librarian-puppet install --clean