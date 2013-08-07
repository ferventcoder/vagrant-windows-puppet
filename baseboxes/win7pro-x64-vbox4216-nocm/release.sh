s3cmd put win7pro-x64-vbox4216-nocm.box s3://vagrant-windows/win7pro-x64-vbox4216-nocm.box.upload
s3cmd del s3://vagrant-windows/win7pro-x64-vbox4216-nocm.box
s3cmd mv s3://vagrant-windows/win7pro-x64-vbox4216-nocm.box.upload s3://vagrant-windows/win7pro-x64-vbox4216-nocm.box