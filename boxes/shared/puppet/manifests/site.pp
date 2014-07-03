
node default {
 package {'roundhouse':
	ensure => latest,
	provider => chocolatey,
 }
}

node 'common' inherits default {
}

node /win*/ inherits 'common' {
 #yup
}

# if "$::puppetversion" != '3.4.3' {
#   exec { 'upgrade_puppet':
#     command => 'C:\\Windows\\SysNative\\msiexec.exe /qn /i http://downloads.puppetlabs.com/windows/puppet-3.4.2.msi',
#   }
# }

# package {'puppet':
  # ensure => '3.4.3',
  # provider => chocolatey,
# }
