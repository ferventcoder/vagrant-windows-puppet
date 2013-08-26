#!/bin/bash

CurrentDir=$(pwd)
BoxBaseName=${PWD##*/}
VMName=win7x64pro
VMPath=~/Documents/Virtual\ Machines.localized/${VMName}.vmwarevm/
BoxName=${BoxBaseName}.box
VagrantBoxName=${VMName}

printf "Creating a vagrant basebox named $BoxName \n"

# Remove existing artifacts
rm -f $BoxName

# Prepare the VM
#vmware-vdiskmanager -R "${VMPath}${VMName}.vmdk"
vmware-vdiskmanager -d "${VMPath}${VMName}.vmdk"
vmware-vdiskmanager -k "${VMPath}${VMName}.vmdk"

# Copy the vagrant files over to the vmware folder
cp -fpv "${CurrentDir}/Vagrantfile" "$VMPath"
cp -fpv "${CurrentDir}/metadata.json" "$VMPath"

# Tar and gzip the box
pushd "$VMPath"
tar --exclude='*.log' --exclude='*.plist' --exclude='*.png' --exclude='appListCache/*' --exclude='appListCache' --exclude='screenshotsCache/*' --exclude='screenshotsCache' --exclude="${VMName}.vmx.lck/*" --exclude="${VMName}.vmx.lck" -cvzf "$CurrentDir/$BoxName" ./*
popd

# Add/update the box
vagrant box add "$VagrantBoxName" $BoxName --provider vmware_fusion --force