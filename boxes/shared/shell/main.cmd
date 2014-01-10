echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallChocolatey.ps1"

echo 'Checking if puppet server has been added to hosts file'
call ping puppet
if %errorlevel% neq 0 goto addpuppethost
goto continue

:addpuppethost
echo 'Adding puppet (192.168.0.2) to hosts file. This is the same private IP that the centos-6.4-x64 box uses.'
echo 192.168.0.2 puppet >> %SystemDrive%\Windows\System32\Drivers\etc\hosts

goto continue

:continue
echo 'Ensuring Time Service is on'
net start w32time
w32tm /resync

echo 'Install puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallPuppetFromMSI.ps1"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;

echo "Ensuring environment for puppet - this puts the puppet ruby on the path for librarian"
call environment.bat
SET FACTER_domain=local

echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\PreparePuppetProvisioner.ps1"

::puppet resource
::call puppet agent --test --debug --verbose
