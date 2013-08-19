echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallChocolatey.ps1"

echo 'Install puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallPuppet.ps1"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;

echo "Ensuring environment for puppet"
call environment.bat
SET FACTER_domain=local

echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\PreparePuppetProvisioner.ps1"