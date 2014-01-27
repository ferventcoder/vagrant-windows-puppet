sudo service puppet stop

sudo mv /usr/lib/ruby/vendor_ruby/puppet/ /usr/lib/ruby/vendor_ruby/puppet.old/
sudo ln -s /code/puppetlabs/puppet/lib/puppet/ /usr/lib/ruby/vendor_ruby/puppet
sudo mv /usr/lib/ruby/vendor_ruby/puppet.rb /usr/lib/ruby/vendor_ruby/puppet.rb.old
sudo ln -s /code/puppetlabs/puppet/lib/puppet.rb /usr/lib/ruby/vendor_ruby/puppet.rb

sudo service puppet start
