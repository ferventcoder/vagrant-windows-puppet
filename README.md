Vagrant Windows Boxes and Puppet
============================

## Prerequisites

 * [Vagrant 1.3.5+](http://downloads.vagrantup.com/tags/v1.3.5) - I'm pretty sure you'll need the latest version
 * [VirtualBox 4.2.16](https://www.virtualbox.org/wiki/Downloads) or VMWare Fusion 5
    * If you want to use VMWare Fusion you will also need the vagrant-vmware-fusion plugin for vagrant (which is not free). You also want the latest version (at least 2.1.0). If you already have this installed, you can upgrade simply by calling `vagrant plugin install vagrant-vmware-fusion`.
 * Vagrant-Windows 1.2.3 - `vagrant plugin install vagrant-windows --plugin-version 1.2.3` - [1.3.0 has issues with Puppet](https://github.com/WinRb/vagrant-windows/issues/135) and [1.3.1 has changed default shell provisioner to powershell instead of command.](https://github.com/WinRb/vagrant-windows/issues/145)
 * At least 20GB free on the host box.
 * **NOTE:** If you file any issues on this repository, please note that I'll ask if you what you have installed and what versions. If it doesn't match the above, I will close your issue until you can reproduce it with the above installed.

## Setup

 1. Install/upgrade Vagrant to 1.3.5+.
 1. Install/upgrade VirtualBox/VMWare to versions listed above.
 1. Install/upgrade required plugins for vagrant (if using VMWare you will need the non-free vagrant-vmware-fusion or equivalent).
 1. Install/upgrade vagrant-windows vagrant plugin. Open terminal/command line and type `vagrant plugin install vagrant-windows`
 1. Take a look at this gist that might be helpful in determining commands to call for setup: [Install Vagrant Windows Environment](https://gist.github.com/ferventcoder/6251225)

## Boxes Folder

 1. Create the `puppet/modules` and `puppet/box_modules` directories in each `boxes` directory that you want to use vagrant in (if it doesn't already exist).
 1. In each folder if you are running VirtualBox, you can just `vagrant up`. If you are running VMWare, you will want to `vagrant up --provider=vmware_fusion`.


### License Requirements for Windows
The boxes provided in the url explicitly state that they need a license for valid use. After downloading the base box you should provide a license.


## Building Windows Boxes for Vagrant
### Base Box Requirements
You must have git installed at a minimum.

What I would recommend to have installed are the following:

 * git (adding the bin directory to the PATH - it's an option during install)
    * this adds all kinds of fun tools to the path, like curl and ls.
 * [BitVise SSH Server](http://www.bitvise.com/ssh-server) - configured with vagrant public key
    * This has the best SSHD and works well with PowerShell REPL
    * Import the vagrant insecure public key for the vagrant user.
    * This allows you to still use `vagrant ssh`
    * Ensure that Public Key authentication for this user is Allowed
  * WinRM and other items configured as noted at [Vagrant-Windows](https://github.com/WinRb/vagrant-windows#creating-a-base-box)
