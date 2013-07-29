echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallChocolatey.ps1"

echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallPuppetAndRequirements.ps1"
