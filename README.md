Vagrant Windows Boxes and Puppet
============================
  
To use this, you need `vagrant` 1.2.7+ and `vagrant-windows` 1.2.0+ plugin installed (still fresh and needs to be built from source).
  
These are the files that end up in your vagrant folder, so you can just clone them prior to doing a vagrant up.  
  
### License Requirements for Windows
The boxes provided in the url explicitly state that they need a license for valid use. After downloading the base box you should provide a license.  
  
### Base Box Requirements
You must have git installed at a minimum.  
  
What I would recommend to have installed are the following: 
  
 * git (adding the bin directory to the PATH - it's an option during install)
    * this adds all kinds of fun tools to the path, like curl and ls.
 * freeSSHD - configured with vagrant public key 
    * You do not need an `authorized_keys` file - freesshd just looks at public keys with a name that EXACTLY matches the user - so `vagrant` and NOT `vagrant.pub` (this will save you a few hours)
    * this allows you to still use vagrant ssh
