sudo service puppetmaster stop

# mv /usr/lib/ruby/site_ruby/1.8/puppet/ /usr/lib/ruby/site_ruby/1.8/puppet.old/
sudo mv /usr/lib/ruby/site_ruby/1.9.1/puppet/ /usr/lib/ruby/site_ruby/1.9.1/puppet.old/
sudo ln -s /code/puppetlabs/puppet/lib/puppet/ /usr/lib/ruby/site_ruby/1.9.1/puppet
sudo mv /usr/lib/ruby/site_ruby/puppet.rb /usr/lib/ruby/site_ruby/puppet.rb.old
sudo ln -s /code/puppetlabs/puppet/lib/puppet.rb /usr/lib/ruby/site_ruby/1.9.1/puppet.rb
