$puppetInstallLocation = "C:\Program Files\Puppet Labs\Puppet"
$puppetInstallLocationX86 = "C:\Program Files (x86)\Puppet Labs\Puppet"

if ([System.IO.Directory]::Exists($puppetInstallLocation) -and ![System.IO.Directory]::Exists("$puppetInstallLocation\puppet.installed")) {
  net stop puppet

  pushd "$puppetInstallLocation\"

  Move-Item "$puppetInstallLocation\puppet" "$puppetInstallLocation\puppet.installed" -Force
  &cmd.exe /c mklink /D `"puppet`" `"C:\code\puppetlabs\puppet`" 2>&1

  Move-Item "$puppetInstallLocation\service" "$puppetInstallLocation\service.installed" -Force
  &cmd.exe /c mklink /D `"service`" `"C:\code\puppetlabs\puppet\ext\windows\service`" 2>&1

  Move-Item "$puppetInstallLocation\sys" "$puppetInstallLocation\sys.installed" -Force
  &cmd.exe /c mklink /D `"sys`" `"C:\code\puppetlabs\puppet-win32-ruby`" 2>&1

  popd
  net start puppet
}

if ([System.IO.Directory]::Exists($puppetInstallLocationX86) -and ![System.IO.Directory]::Exists("$puppetInstallLocationX86\puppet.installed")) {
  net stop puppet

  pushd "$puppetInstallLocationX86\"

  Move-Item "$puppetInstallLocationX86\puppet" "$puppetInstallLocationX86\puppet.installed" -Force
  &cmd.exe /c mklink /D `"puppet`" `"C:\code\puppetlabs\puppet`" 2>&1

  Move-Item "$puppetInstallLocationX86\service" "$puppetInstallLocationX86\service.installed" -Force
  &cmd.exe /c mklink /D `"service`" `"C:\code\puppetlabs\puppet\ext\windows\service`" 2>&1

  Move-Item "$puppetInstallLocationX86\sys" "$puppetInstallLocationX86\sys.installed" -Force
  &cmd.exe /c mklink /D `"sys`" `"C:\code\puppetlabs\puppet-win32-ruby`" 2>&1

  popd
  net start puppet
}

# &"C:\Program Files\Puppet Labs\Puppet\bin\environment.bat"

# choco install ruby2.devkit -y
# Move-Item C:\DevKit\config.yml config.yml.old -Force
# &cmd.exe /c mklink C:\DevKit\config.yml C:\vagrantshared\shell\config.yml
# &ruby C:\DevKit\dk.rb install

# &gem install debug_inspector -v '0.0.2'
# &gem install debugger
# &gem install debugger -v '1.6.2'
# &gem install bundler

# &puppet apply -e "user {'Administrator': ensure=>present, groups=>['Administrators'],}"

# pushd "C:\Program Files\Puppet Labs\Puppet\puppet"
# &bundle install
