# Set the hostname to puppet
sudo hostname puppet

# RHEL - sudo vim /etc/sysconfig/network
sudo service network restart

# Deb - sudo vim /etc/hosts (must add puppet to 127.0.0.1)
#sudo service networking stop
#sudo service networking start

