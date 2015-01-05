$env:PATH +=";$env:SystemDrive\ProgramData\Chocolatey\bin;$env:SystemDrive\Documents and Settings\All Users\Application Data\chocolatey\bin"

write-host "This should be run from the root of your puppet code base"

choco install ruby -version 2.1.5
$env:PATH += ";$env:SystemDrive\tools\ruby215\bin"
#choco install ruby.devkit
choco install ruby2.devkit
# NOTE: You may need to go to c:\tools\DevKit2:
#  - update the config.yml to include c:/tools/ruby215
#  - run 'ruby dk.rb install'

# https://gist.github.com/luislavena/f064211759ee0f806c88
$ssl_cert = 'C:\tools\ruby215\lib\ruby\2.1.0\rubygems\ssl_certs\AddTrustExternalCARoot-2048.pem'
$ssl_cert_url = 'https://raw.githubusercontent.com/rubygems/rubygems/master/lib/rubygems/ssl_certs/AddTrustExternalCARoot-2048.pem'
&curl -o "$ssl_cert" "$ssl_cert_url"
&gem install --no-ri --no-rdoc bundler
&bundler config --global jobs 4
&gem install --no-ri --no-rdoc debug_inspector -v '0.0.2'
#&gem install debugger-ruby_core_source -v '1.2.3'
&gem install --no-ri --no-rdoc debugger
#&gem install --no-ri --no-rdoc debugger -v '1.6.2'
&bundle install

# ensure the directory
New-Item -Path "$env:ProgramData\PuppetLabs\puppet" -ItemType directory | Out-Null
&bundle exec puppet apply -e "user {'Administrator': ensure=>present, groups=>['Administrators'],}"
