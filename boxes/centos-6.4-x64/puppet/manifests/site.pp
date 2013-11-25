node default {

}

node /^win2003.*$/ {

  file { 'c:/temp':
    ensure => directory,
  }

  file { 'c:/temp/test.txt':
    ensure => file,
    source => "puppet:///modules/permissionstest/test.txt",
  }

  file { 'c:/temp/test-ignored.txt':
    ensure => file,
    source => "puppet:///modules/permissionstest/test.txt",
  }

  file {'c:/temp/test-content.txt':
    ensure => file,
    content => 'This is not managed by source.'
  }

  file { 'c:/temp/test-setmode.txt':
    ensure => file,
    mode => 0640,
    owner => 'Administrators',
    group => 'SYSTEM',
    source => "puppet:///modules/permissionstest/test-setmode.txt",
  }
}

node /^win7.*$/ {

  file { 'c:/temp':
    ensure => directory,
  }

  file {'c:/temp/acls/mode_dir/bob-nosource.txt':
    ensure => file,
    content => 'dude',
  }

  file {'c:/temp/acls/mode_dir/bob.txt':
    ensure => file,
    content => 'dude-dude',
  }

  file {'c:/temp/acls/SomeUser':
    ensure  => directory,
    owner   => 'Administrator',
    group   => 'Administrator',
    mode    => '0775',
  }

  file {'c:/temp/acls/SomeUser/SomeFile.txt':
    ensure => file,
    content => 'yes',
  }

  file {'c:/temp/acls/mode_dir/bob-sourced.txt':
    ensure => file,
    source_permissions => ignore,
    source => "puppet:///modules/permissionstest/test.txt",
  }

  file { 'c:/temp/test.txt':
    ensure => file,
    group => 'SYSTEM',
    source => "puppet:///modules/permissionstest/test.txt",
  }

  file { 'c:/temp/test-ignored.txt':
    ensure => file,
    source_permissions => ignore,
    source => "puppet:///modules/permissionstest/test.txt",
  }

  file {'c:/temp/test-content.txt':
    ensure => file,
    content => 'This is not managed by source.'
  }

  file { 'c:/temp/test-setmode.txt':
    ensure => file,
    mode => 0640,
    owner => 'Administrators',
    group => 'SYSTEM',
    source => "puppet:///modules/permissionstest/test-setmode.txt",
  }
}
