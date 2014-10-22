#Puppet Install
# http://docs.puppetlabs.com/guides/installation.html#debian-and-ubuntu

# Add the Deb
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update

# Install Puppet On Agent
sudo apt-get install puppet -y -qq

# http://docs.puppetlabs.com/guides/installation.html#post-install
# Master
sudo puppet resource service puppet ensure=running enable=true
# Agent
#sudo puppet resource service puppet ensure=running enable=true
