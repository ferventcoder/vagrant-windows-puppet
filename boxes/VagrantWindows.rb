Vagrant.require_version ">= 1.3.5" #, "< 1.6.5"
if Vagrant::VERSION < '1.6.0'
  Vagrant.require_plugin "vagrant-windows"
end

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |v|
    v.gui = true
    v.linked_clone = true if Vagrant::VERSION >= '1.8.0'
    # customize
    #v.customize ["modifyvm", :id, "--memory", "1024"]
    #v.customize ["modifyvm", :id, "--cpus", "2"]
    #v.customize ["modifyvm", :id, "--vram", 32]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--audio", "none"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--usb", "off"]
  end

  config.vm.provider :vmware_fusion do |v|
    v.gui = true
    v.linked_clone = true if Vagrant::VERSION >= '1.8.0'
    # customize
    #v.vmx["memsize"] = "1024"
    #v.vmx["numvcpus"] = "2"
    v.vmx["usb.present"] = "false"
    v.vmx["sound.present"] = "false"
    v.vmx["ide1:0.present"] = "false"
  end

  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.guest = :windows
  # https://www.vagrantup.com/blog/feature-preview-vagrant-1-6-windows.html

  if Vagrant::VERSION >= '1.6.0'
    config.vm.communicator = "winrm"
  end

  # Port forward WinRM / RDP
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  # Port forward SSH (ssh is forwarded by default in most versions of Vagrant, but be sure)
  #  It's not necessary if you are not using SSH, but it doesn't hurt anything to have it
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
  config.vm.network :forwarded_port, guest: 80, host: 9080, id: "web", auto_correct: true

  #from the perspective of the box itself, not the current directory
  config.vm.synced_folder "../shared", "/vagrantshared"
end
