s3cmd put win7pro-x64-vmwarefusion5-nocm.box s3://vagrant-windows/win7pro-x64-vmwarefusion5-nocm.box.upload
s3cmd del s3://vagrant-windows/win7pro-x64-vmwarefusion5-nocm.box
s3cmd mv s3://vagrant-windows/win7pro-x64-vmwarefusion5-nocm.box.upload s3://vagrant-windows/win7pro-x64-vmwarefusion5-nocm.box