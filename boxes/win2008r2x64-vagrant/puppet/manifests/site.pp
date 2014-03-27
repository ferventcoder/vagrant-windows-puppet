#  package {'poshgit':
#   ensure => latest,
#   provider => 'chocolatey',
#   source => 'c:\vagrant\resources\packages;http://chocolatey.org/api/v2/',
# }


# file { 'c:/temp/setup_env.bat':
#   ensure => file,
#   provider => windows,
#   #owner => 'Administrators',
#   #group => 'SYSTEM',
#   content => template("c:/vagrant/puppet/manifests/templates/setup_env.bat.erb"),
# }

# exec { 'setup_env.bat':
#   command => 'c:/temp/setup_env.bat',
#   #cwd => 'c:\temp',
#   #path => 'c:\temp;%PATH%',
#   provider => windows,
#   require => File['c:/temp/setup_env.bat'],
# }

# file {'c:/temp/moded':
#   ensure => directory,
#   owner => 'Administrators',
#   group => 'SYSTEM',
#   mode => 0770,
# }

# file {'c:/temp/moded_vagrant':
#   ensure => directory,
#   owner => 'Administrators',
#   group => 'vagrant',
#   mode => 0770,
# }

# file {'c:/temp/moded.txt':
#   ensure => file,
#   owner => 'Administrators',
#   group => 'SYSTEM',
#   mode => 0770,
#   content => 'ah',
# }

# # file {'c:/temp/moded.txt':
# #   ensure => file,
# #   group => 'bob',
# #   #mode => 0770,
# #   content => 'ah',
# # }

# file {'c:/temp':
#   ensure => directory,
# }

# file {'c:/temp/moded_vagrant.txt':
#   ensure => file,
#   owner => 'Administrators',
#   group => 'vagrant',
#   mode => 0770,
#   content => 'ah',
# }

# file {'c:/temp/nomode':
#   ensure => directory,
#   owner => 'Administrators',
#   group => 'SYSTEM',
# }

# file {'c:/temp/nomode.txt':
#   ensure => file,
#   owner => 'Administrators',
#   group => 'SYSTEM',
#   content => 'wat?'
# }

# user {'bob':
#   ensure => present,
#   password => 'bob',
#   groups => ['Users']
# }

# file {'c:/temp/nomode_bob_group.txt':
#   ensure => file,
#   group => 'bob',
#   content => 'wat?',
#   require => User['bob'],
# }

# file {'c:/temp/nomode_bob_owner.txt':
#   ensure => file,
#   owner => 'bob',
#   content => 'wat?',
#   require => User['bob'],
# }

# file {'c:/temp/nomode_bob_both.txt':
#   ensure => file,
#   owner => 'bob',
#   group => 'bob',
#   content => 'wat?',
#   require => User['bob'],
# }

# file {'c:/temp/nomode_bob_group':
#   ensure => directory,
#   group => 'bob',
#   require => User['bob'],
# }

# file {'c:/temp/nomode_bob_owner':
#   ensure => directory,
#   owner => 'bob',
#   require => User['bob'],
# }

# file {'c:/temp/nomode_bob_both':
#   ensure => directory,
#   owner => 'bob',
#   group => 'bob',
#   require => User['bob'],
# }
