rm -f  win7pro-x64-vbox4216-nocm.box
tar --exclude='*.sh' -cvzf win7pro-x64-vbox4216-nocm.box  ./*
vagrant box add win7x64pro win7pro-x64-vbox4216-nocm.box --provider virtualbox --force