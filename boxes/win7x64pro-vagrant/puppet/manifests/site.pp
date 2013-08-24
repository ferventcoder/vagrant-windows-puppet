
# package {'name_of_package':
#   provider => 'chocolatey',
#   ensure => absent,latest, '1.0',
#   source => 'http://not/default/sources;c:\local;\\some\network\share',
#   install_options => '-installArgs "addtl args for native installer"',
# }


# package {'git':
#   ensure => '1.8.1.2',
#   provider => 'chocolatey',
#   #install_options => '',
#   source => 'c:\vagrant\resources\packages',
# }

package {'git.install':
  ensure => latest,
  provider => 'chocolatey',
  source => 'c:\vagrant\resources\packages',
}

 package {'poshgit':
  ensure => latest,
  provider => 'chocolatey',
  source => 'c:\vagrant\resources\packages',
}

# package {'putty':
#   ensure => latest,
#   provider => 'chocolatey',
# }

package {'putty':
  ensure => absent,
  provider => 'chocolatey',
}
