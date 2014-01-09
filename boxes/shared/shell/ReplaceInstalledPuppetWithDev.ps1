net stop puppet

Move-Item "C:\Program Files (x86)\Puppet Labs\Puppet\puppet" "C:\Program Files (x86)\Puppet Labs\Puppet\puppet.installed" -Force
pushd "C:\Program Files (x86)\Puppet Labs\Puppet\"
&cmd.exe /c mklink /D `"puppet`" `"C:\code\puppetlabs\puppet`" 2>&1
popd

net start puppet
