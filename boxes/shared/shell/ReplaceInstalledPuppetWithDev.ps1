if (![System.IO.Directory]::Exists('C:\Program Files (x86)\Puppet Labs\Puppet\puppet.installed')) {
  net stop puppet

  Move-Item "C:\Program Files (x86)\Puppet Labs\Puppet\puppet" "C:\Program Files (x86)\Puppet Labs\Puppet\puppet.installed" -Force
  pushd "C:\Program Files (x86)\Puppet Labs\Puppet\"
  &cmd.exe /c mklink /D `"puppet`" `"C:\code\puppetlabs\puppet`" 2>&1
  popd

  net start puppet
}

&"C:\Program Files (x86)\Puppet Labs\Puppet\bin\environment.bat"

choco install ruby.devkit
Move-Item C:\DevKit\config.yml config.yml.old -Force
&cmd.exe /c mklink C:\DevKit\config.yml C:\vagrantshared\shell\config.yml
&ruby C:\DevKit\dk.rb install

&gem install debug_inspector -v '0.0.2'
&gem install debugger
&gem install debugger -v '1.6.2'
&gem install bundler

&puppet apply -e "user {'Administrator': ensure=>present, groups=>['Administrators'],}"

pushd "C:\Program Files (x86)\Puppet Labs\Puppet\puppet"
&bundle install
