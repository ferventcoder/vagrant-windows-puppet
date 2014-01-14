@echo off

SET FACTER_domain='local'
SET FACTER_kernel='windows'
SET FACTER_operatingsystem='windows'
SET FACTER_osfamily='windows'

bundle exec puppet apply --debug --trace --verbose --modulepath 'C:/ProgramData/PuppetLabs/puppet/etc/modules;C:/vagrantshared/puppet/modules;C:/vagrant/puppet/modules' --manifestdir 'C:/vagrantshared/puppet/manifests' --detailed-exitcodes 'C:/vagrantshared/puppet/manifests/pup1389.pp'

exit /b %ERRORLEVEL%
