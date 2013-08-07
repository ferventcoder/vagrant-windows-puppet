CurrentDir=$(pwd)
BoxBaseName=${PWD##*/}
VMWareDir=~/Documents/Virtual\ Machines.localized/win7x64pro.vmwarevm/
BoxName=${BoxBaseName}.box

printf "Creating a vagrant basebox named $BoxName \n"

rm -f $BoxName
# Compress and prepare the VM
vmware-vdiskmanager -d "${VMWareDir}win7x64pro.vmdk"
vmware-vdiskmanager -k "${VMWareDir}win7x64pro.vmdk"

# Copy the vagrant files over to the vmware folder
cp -fpv "${CurrentDir}/Vagrantfile" "$VMWareDir"
cp -fpv "${CurrentDir}/metadata.json" "$VMWareDir"

# Tar and gzip the box
pushd "$VMWareDir"
tar --exclude='*.log' --exclude='*.plist' --exclude='*.png' --exclude='appListCache/*' --exclude='appListCache' --exclude='screenshotsCache/*' --exclude='screenshotsCache' --exclude='win7x64pro.vmx.lck/*' --exclude='win7x64pro.vmx.lck' -cvzf "$CurrentDir/$BoxName" ./*
popd
# Add/update the box
vagrant box add win7x64pro-vmware $BoxName --provider vmware_fusion --force