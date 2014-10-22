#Puppet Master Install
# http://docs.puppetlabs.com/guides/installation.html#red-hat-enterprise-linux-and-derivatives

# add the RPM
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-red-hat-enterprise-linux-and-derivatives
sudo rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
#sudo yum -y install puppet
sudo yum -y install puppet-server

# autosign on - never use this for production
sudo sh -c "echo * > /etc/puppet/autosign.conf"

# http://docs.puppetlabs.com/guides/installation.html#post-install
sudo puppet resource service puppetmaster ensure=running enable=true
