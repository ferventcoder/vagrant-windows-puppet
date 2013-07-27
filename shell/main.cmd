echo 'Installing chocolatey'
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"

echo 'Attempting to add chocolatey to the PATH'
SET PATH=%PATH%;%systemdrive%\chocolatey\bin
echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallNet4.ps1"
echo 'Update Chocolatey to Latest version'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\ChocolateyUpdateToPrerelease.ps1"

echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallPuppetAndRequirements.ps1"
