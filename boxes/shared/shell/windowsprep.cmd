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

:: Ensuring certificates are installed if box isn't updated
certutil -v -addstore Root "c:\vagrantshared\resources\certs\geotrust.global.pem"
certutil -v -addstore Root "c:\vagrantshared\resources\certs\usertrust.network.pem"

exit 0
