#Puppet Install
# http://docs.puppetlabs.com/guides/installation.html#debian-and-ubuntu

# ensure the date/time is synced
sudo ntpdate us.pool.ntp.org

# Add the Deb
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update

# Install Puppet Master
#sudo apt-get install puppetmaster -y
# - OR -
# Install Puppet On Agent
sudo apt-get install puppet -y
# - OR -
# Install Standalone Puppet
#sudo apt-get install puppet-common -y #-qq

# http://docs.puppetlabs.com/guides/installation.html#post-install
# Master
#sudo puppet resource service puppetmaster ensure=running enable=true
# Agent
sudo puppet resource service puppet ensure=running enable=true
