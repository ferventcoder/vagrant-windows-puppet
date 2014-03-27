# if "$::puppetversion" != '3.4.3' {
#   exec { 'upgrade_puppet':
#     command => 'C:\\Windows\\SysNative\\msiexec.exe /qn /i http://downloads.puppetlabs.com/windows/puppet-3.4.2.msi',
#   }
# }

package {'puppet':
  ensure => '3.4.3',
  provider => chocolatey,
}
