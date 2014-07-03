sudo service puppetmaster stop

#$ruby_ver=1.8
#$ruby_ver=1.9.1

sudo mv /usr/lib/ruby/site_ruby/1.8/puppet/ /usr/lib/ruby/site_ruby/1.8/puppet.old/
sudo ln -s /code/puppetlabs/puppet/lib/puppet/ /usr/lib/ruby/site_ruby/1.8/puppet
sudo mv /usr/lib/ruby/site_ruby/1.8/puppet.rb /usr/lib/ruby/site_ruby/1.8/puppet.rb.old
sudo ln -s /code/puppetlabs/puppet/lib/puppet.rb /usr/lib/ruby/site_ruby/1.8/puppet.rb
