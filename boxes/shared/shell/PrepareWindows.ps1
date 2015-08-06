function Add-PuppetMasterToHostsFile {
  # Centos 6.5
  Write-Host 'Adding puppet (192.168.0.6) to hosts file. This is the same private IP that the centos-6.4-x64 box uses.'
  Add-Content $env:SystemDrive\Windows\System32\Drivers\etc\hosts "`r`n192.168.0.6     puppet"

  # Ubuntu 12.04
  #Write-Host 'Adding puppet (192.168.0.4) to hosts file. This is the same private IP that the centos-6.4-x64 box uses.'
  #Add-Content $env:SystemDrive\Windows\System32\Drivers\etc\hosts "`r`n192.168.0.4     puppet"
}

#Write-Host 'Checking if puppet server has been added to hosts file'
try {
  Test-Connection puppet -ErrorAction Stop
} catch {
  Add-PuppetMasterToHostsFile
}

#Write-Host 'Ensuring Time Service is on'
cmd.exe /c "net start w32time  2>&1"
cmd.exe /c "w32tm /resync  2>&1"

#Write-Host 'Ensuring TCP/IP NetBIOS Helper Service (lmhosts) is on'
cmd.exe /c "sc config lmhosts start= auto 2>&1"
cmd.exe /c "net start lmhosts 2>&1"

#Write-Host "Ensuring certificates are installed if box isn't updated"
certutil -v -addstore Root "c:\vagrantshared\resources\certs\geotrust.global.pem"
certutil -v -addstore Root "c:\vagrantshared\resources\certs\usertrust.network.pem"
