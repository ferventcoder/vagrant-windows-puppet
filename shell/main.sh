#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=C:/ProgramData/PuppetLabs/puppet
mkdir c:/ProgramData/PuppetLabs
mkdir c:/ProgramData/PuppetLabs/puppet

$(which chocolatey > /dev/null 2>&1)
FOUND_CHOCO=$? 
if [ "$FOUND_CHOCO" -ne '0' ]; then
  echo 'Attempting to install chocolatey'
  powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
fi

echo 'Attempting to add chocolatey to the PATH'
PATH=/c/Chocolatey/bin:$PATH
echo 'Ensuring .NET 4.0 is installed'
powershell -NoProfile -ExecutionPolicy Bypass -File ./InstallNet4.ps1
echo 'Update Chocolatey to Latest version'
powershell -NoProfile -ExecutionPolicy Bypass -File ./ChocolateyUpdateToPrerelease.ps1

echo 'Install Ruby/Git if missing'
# Attempting ruby install
$(which ruby > /dev/null 2>&1)
FOUND_RUBY=$?
if [ "$FOUND_RUBY" -ne '0' ]; then
  echo 'Attempting to install ruby.'
  $(which choco > /dev/null 2>&1)
  FOUND_CHOCO=$?
  
  if [ "${FOUND_CHOCO}" -eq '0' ]; then
    choco install ruby -Version 1.9.3.44800 -force
    echo 'Ruby installed.'
  else
    echo 'No package installer available. You may need to install ruby manually.'
  fi
else
  echo 'Ruby found.'
fi

# NB: librarian-puppet might need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum
$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
  echo 'Attempting to install git.'
  $(which choco > /dev/null 2>&1)
  FOUND_CHOCO=$?
  
  if [ "${FOUND_CHOCO}" -eq '0' ]; then
    choco install git -force
    choco install git.install -force
    echo 'Git installed.'
  else
    echo 'No package installer available. You may need to install git manually.'
  fi
else
  echo 'Git found.'
fi

cp c:/vagrant/puppet/Puppetfile $PUPPET_DIR

echo 'Attempting to add ruby to the PATH'
PATH=/c/ruby193/bin:$PATH

gem install puppet --no-ri --no-rdoc

if [ "$(gem search -i librarian-puppet)" = "false" ]; then
  gem install librarian-puppet --no-ri --no-rdoc
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi