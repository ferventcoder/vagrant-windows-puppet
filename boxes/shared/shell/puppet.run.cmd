@echo off

bundle exec puppet apply --debug --trace --verbose --modulepath "C:/vagrant/puppet/modules;C:/ProgramData/PuppetLabs/puppet/etc/modules" "C:\vagrant\puppet\manifests\site.pp"
