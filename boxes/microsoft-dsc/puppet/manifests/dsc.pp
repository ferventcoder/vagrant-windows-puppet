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

dsc_file { 'TestFileCreds':
  dsc_ensure          => 'present',
  dsc_contents        => 'hi! testcontent',
  dsc_destinationpath => 'c:\testdsc\test.txt',
  dsc_psdscrunascredential => {'user' => 'vagrant', 'password' => 'vagrant'},
} ->

dsc_xgroup {'testgroup':
  dsc_ensure          => 'present',
  dsc_groupname       => 'TestUsers',
  dsc_members         => 'vagrant',
}
