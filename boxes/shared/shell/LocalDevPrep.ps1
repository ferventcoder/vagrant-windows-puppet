$env:PATH +=";$env:SystemDrive\Chocolatey\bin"

write-host "This should be run from the root of your puppet code base"

choco install ruby -version 1.9.3.54500
$env:PATH += ";$env:SystemDrive\ruby193\bin"
choco install ruby.devkit
&gem install --no-ri --no-rdoc bundler
&bundler config --global jobs 4
&gem install --no-ri --no-rdoc debug_inspector -v '0.0.2'
#&gem install debugger-ruby_core_source -v '1.2.3'
&gem install --no-ri --no-rdoc debugger
&gem install --no-ri --no-rdoc debugger -v '1.6.2'
&bundle install

# ensure the directory
New-Item -Path "$env:ProgramData\PuppetLabs\puppet" -ItemType directory | Out-Null
&bundle exec puppet apply -e "user {'Administrator': ensure=>present, groups=>['Administrators'],}"
