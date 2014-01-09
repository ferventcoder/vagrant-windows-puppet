
call "C:\Program Files (x86)\Puppet Labs\Puppet\bin\environment.bat"
call choco install ruby.devkit
rename C:\DevKit\config.yml config.yml.old
mklink C:\DevKit\config.yml C:\vagrantshared\shell\config.yml
call ruby C:\DevKit\dk.rb install

call gem install debug_inspector -v '0.0.2'

call puppet apply -e "user {'Administrator': ensure=>present, groups=>['Administrators'],}"

pushd "C:\Program Files (x86)\Puppet Labs\Puppet\puppet"
bundle install
