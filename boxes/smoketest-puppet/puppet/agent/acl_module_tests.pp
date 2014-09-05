
class acl {
  file {'c:/temp':
    ensure => directory,
  }

  acl { 'c:/temp':
    owner                      => 'SYSTEM',
    group                      => 'Administrators',
    inherit_parent_permissions => 'false',
    permissions                => [
     { 'identity' => 'BUILTIN\Administrators', 'rights' => ['full'] }
    ],
    purge                      => 'true',
  }
}


include acl
