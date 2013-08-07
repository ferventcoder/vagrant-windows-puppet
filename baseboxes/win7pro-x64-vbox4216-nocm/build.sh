CurrentDir=$(pwd)
BoxBaseName=${PWD##*/}
VMName=win7x64pro
VMPath=~/VirtualBox\ VMs/${VMName}/${VMName}.vbox
BoxName=${BoxBaseName}.box
OVFName=box.ovf

printf "Creating a vagrant basebox named $BoxName \n"

# Remove existing artifacts
rm -f box-disk1.vmdk
rm -f box.ovf
rm -f $BoxName

# Prepare the VM
vboxmanage export "$VMPath" -o $OVFName --vsys 0 --eula "This is for evaluation purposes only. You must provide a valid license to use this box."

# Tar and gzip the box
tar --exclude='*.sh' -cvzf $BoxName ./*

# Add/update the box
vagrant box add $VMName $BoxName --provider virtualbox --force