
# dsc_file {'testfile':
#   dsc_ensure => 'present',
#   dsc_contents => 'yesdreadfasdf',
#   dsc_destinationpath => 'c:\test.txt',
# } ->

# dsc_xarchive {'dude_archive':
#   dsc_destination => 'c:\test.zip',
#   dsc_path => ['c:\test.txt'],
#   dsc_compressionlevel => 'Fastest',
#   dsc_destinationtype => 'File',
# } ->

dsc_xgroup {'testgroup':
  dsc_ensure => 'present',
  dsc_groupname => 'TestUsers',
  dsc_members => 'vagrant',
}
