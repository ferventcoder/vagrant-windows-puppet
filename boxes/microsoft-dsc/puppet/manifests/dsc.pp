dsc_file {'TestDirectory':
  dsc_ensure          => 'present',
  dsc_type            => 'Directory',
  dsc_destinationpath => 'c:\testdsc',
} ->

dsc_file { 'TestFile':
  dsc_ensure          => 'present',
  dsc_contents        => 'hi! testcontent',
  dsc_destinationpath => 'c:\testdsc\test.txt',
} ->

dsc_xgroup {'testgroup':
  dsc_ensure          => 'present',
  dsc_groupname       => 'TestUsersDSC',
  dsc_members         => ['vagrant','Administrators'],
} ->

dsc_xgroup {'testgroup2':
  dsc_ensure          => 'present',
  dsc_groupname       => 'TestUsers2DSC',
  dsc_members         => 'vagrant',
} ->

dsc_xFirewall { 'inbound-2222':
  dsc_ensure => 'present',
  dsc_name => 'inbound2222',
  dsc_displayname => 'Inbound DSC 2222 Test',
  dsc_displaygroup => 'A Puppet + DSC Test',
  dsc_action => 'Allow',
  dsc_enabled => 'false',
  dsc_direction => 'Inbound',
} ->

dsc_xArchive {'fooarchive':
  dsc_path => ['c:\\ProgramData\\PuppetLabs\\Puppet\\etc'],
  dsc_destination => 'c:\\puppet-etc.zip',
  dsc_compressionlevel => 'Fastest',
  dsc_destinationtype  => 'File',
}
