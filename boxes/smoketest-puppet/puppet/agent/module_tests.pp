
class acl {
  file {'c:/temp':
    ensure => directory,
  }

  acl { 'c:/temp':
    owner                      => 'SYSTEM',
    group                      => 'Administrators',
    inherit_parent_permissions => 'false',
    permissions                => [ { 'identity' => 'BUILTIN\Administrators', 'rights' => ['full'] } ]
  }
}

class registry {
  registry_key { 'HKLM\Software\Puppet Labs':
    ensure => present
  }

  registry_value { 'HKLM\Software\Puppet Labs\array':
    ensure => present,
    type   => array,
    data   => ['one', 'two'],
  }

  registry_value { 'HKLM\Software\Puppet Labs\expand':
    ensure => present,
    type   => expand,
    data   => '%SYSTEMROOT%',
  }

  registry_value { 'HKLM\Software\Puppet Labs\binary':
    ensure => present,
    type   => binary,
    data   => 'DE AD BE EF 01 23 45 67 89',
  }
}

class powershell {
  exec { 'Write $env:PATH':
    provider  => powershell,
    logoutput => true
  }
}
class reboot {
  notify { 'now':
  } ~>
  reboot { 'now':
  }
}

include acl
include powershell
include registry
include reboot
