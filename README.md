Vagrant Windows Boxes and Puppet
============================
  
To use this, you need `vagrant` 1.1.x and `vagrant-windows` plugin installed. Vagrant-windows has an experimental 1.2 branch which will allow you to take advantage of vagrant 1.2.x and the latest features.  
  
These are the files that end up in your vagrant folder, so you can just clone them prior to doing a vagrant up.  
  
### Base Box Requirements
You must have git installed at a minimum.  
  
What I would recommend to have installed are the following: 
  
 * git (adding the bin directory to the PATH - it's an option during install)
    * this adds all kinds of fun tools to the path, like curl and ls.
 * freeSSHD - configured with vagrant public key 
    * You do not need an `authorized_keys` file - freesshd just looks at public keys with a name that EXACTLY matches the user - so `vagrant` and NOT `vagrant.pub` (this will save you a few hours)
    * this allows you to still use vagrant ssh
