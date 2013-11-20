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

  file { 'c:/temp/test.txt':
    ensure => file,
    source_permissions => ignore,
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
    source_permissions => ignore,
    source => "puppet:///modules/permissionstest/test-setmode.txt",
  }
}
