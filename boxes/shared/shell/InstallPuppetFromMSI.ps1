$MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-3.6.2.msi"
$PuppetInstallerPath = 'c:\vagrantshared\resources\installers'
$PuppetInstallerFile = 'puppet.msi'
#$PuppetInstallerFile = 'puppet-2984.msi'
#$PuppetInstallerFile = 'puppet-2984-x64.msi'
$PuppetInstaller = Join-Path $PuppetInstallerPath $PuppetInstallerFile

$PuppetInstalled = $false
try {
  $ErrorActionPreference = "Stop";
  Get-Command puppet | Out-Null
  $PuppetInstalled = $true
  $PuppetVersion=&puppet "--version"
  Write-Host "Puppet $PuppetVersion is installed. This process does not ensure the exact version or at least version specified, but only that puppet is installed. Exiting..."
  Exit 0
} catch {
  Write-Host "Puppet is not installed, continuing..."
}

if (!($PuppetInstalled)) {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  if (! ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Host -ForegroundColor Red "You must run this script as an administrator."
    Exit 1
  }

  if (!(Test-Path $PuppetInstallerPath)) {
    Write-Host "Creating folder `'$PuppetInstallerPath`'"
    $null = New-Item -Path "$PuppetInstallerPath" -ItemType Directory
  }

  if (!(Test-Path $PuppetInstaller)) {
    Write-Host "Downloading `'$MsiUrl`' to `'$PuppetInstaller`'"
    (New-Object Net.WebClient).DownloadFile("$MsiUrl","$PuppetInstaller")
  }


  # Install it - msiexec will download from the url
  $install_args = @("/qn", "/norestart","/i", "$PuppetInstaller")
  Write-Host "Installing Puppet. Running msiexec.exe $install_args"
  $process = Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
  if ($process.ExitCode -ne 0) {
    Write-Host "Installer failed."
    Exit 1
  }

  Write-Host "Puppet successfully installed."
}
