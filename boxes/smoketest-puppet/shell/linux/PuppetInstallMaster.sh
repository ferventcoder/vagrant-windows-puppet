#Puppet Master Install
# http://docs.puppetlabs.com/guides/installation.html#red-hat-enterprise-linux-and-derivatives
# https://docs.puppet.com/puppetserver/2.3/install_from_packages.html

# add the RPM
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-red-hat-enterprise-linux-and-derivatives
# https://docs.puppet.com/puppet/latest/reference/puppet_collections.html
#sudo rpm -Uvh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
#sudo yum -y install puppet
# 3.x series
#sudo yum -y install puppet-server
# 4.x series
sudo yum -y install puppetserver

# Debian
# 3.x series
# sudo apt-get install -y puppet-server
# 4.x series
# sudo apt-get install -y puppetserver

# autosign on - never use this for production
sudo sh -c "echo * > /etc/puppet/autosign.conf"

# http://docs.puppetlabs.com/guides/installation.html#post-install
# 3.x series
#sudo puppet resource service puppetserver ensure=running enable=true
# 4.x series
#sudo systemctl start puppetserver
sudo service puppetserver start
