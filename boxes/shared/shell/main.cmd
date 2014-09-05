echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallChocolatey.ps1"

echo 'Checking if puppet server has been added to hosts file'
call ping puppet
if %errorlevel% neq 0 goto addpuppethost
goto continue

:addpuppethost
:: Centos 6.5
echo 'Adding puppet (192.168.0.6) to hosts file. This is the same private IP that the centos-6.4-x64 box uses.'
echo 192.168.0.6 puppet >> %SystemDrive%\Windows\System32\Drivers\etc\hosts

:: Ubuntu 12.04
::echo 'Adding puppet (192.168.0.4) to hosts file. This is the same private IP that the centos-6.4-x64 box uses.'
::echo 192.168.0.4 puppet >> %SystemDrive%\Windows\System32\Drivers\etc\hosts

goto continue

:continue
echo 'Ensuring Time Service is on'
net start w32time
w32tm /resync

echo 'Ensuring TCP/IP NetBIOS Helper Service (lmhosts) is on'
sc config lmhosts start= auto
net start lmhosts

echo 'Install puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallPuppetFromMSI.ps1"

:: Ensuring certificates are installed if box isn't updated
certutil -v -addstore Root "c:\vagrantshared\resources\certs\geotrust.global.pem"
certutil -v -addstore Root "c:\vagrantshared\resources\certs\usertrust.network.pem"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;

echo "Ensuring environment for puppet - this puts the puppet ruby on the path for librarian"
call environment.bat
SET FACTER_domain=local

echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\PreparePuppetProvisioner.ps1"

::puppet resource
::call puppet agent --test --debug --verbose
