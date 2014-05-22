case $::operatingsystem {
  windows: {
    Package {
      provider => chocolatey,
    }
  }
}


node default {
  package { 'vim':
    ensure => installed,
  }
}

node centos {
  file { '/home/vagrant/from_master_sync':
    ensure => file,
    content => 'This was put here on a master sync',
  }
}

node ubuntu {
  file { '/home/vagrant/from_master_sync':
    ensure => file,
    content => 'This was put here on a master sync',
  }
}

# any box that starts with win
node /^win.*$/ {
  file { [
    'c:/users/administrator/desktop'
  ]:
    ensure => directory,
  }

  file { 'c:/users/administrator/desktop/from_master_sync.txt':
    ensure => file,
    content => 'This was put here on a master sync',
  }

  package {'roundhouse':
    ensure => installed,
    source => 'c:/vagrant/resources/packages',
  }
}

