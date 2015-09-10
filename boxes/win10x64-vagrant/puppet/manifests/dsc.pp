dsc::lcm_config {'disable':} ->
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

dsc_windowsoptionalfeature {'dsc_optional_telnetclient':
  dsc_ensure => 'disable',
  dsc_name => 'telnetclient',
} ->

dsc_xgroup {'testgroup':
  dsc_ensure          => 'present',
  dsc_groupname       => 'TestUsers',
  dsc_members         => 'vagrant',
}
