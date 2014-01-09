#  package {'poshgit':
#   ensure => latest,
#   provider => 'chocolatey',
#   source => 'c:\vagrant\resources\packages;http://chocolatey.org/api/v2/',
# }

$slave_home = "c:/Bob/jenkins-slave"

file { ["c:/Bob",$slave_home]:
  ensure => directory,
}

file { "${slave_home}/jenkins-slave.exe":
  ensure => file,
  mode => '0777',
  source => 'puppet:///modules/jenkins/jenkins-slave.exe',
  source_permissions => ignore,
  require => File[$slave_home],
  backup => false,
}

# file { "${slave_home}/jenkins-slave.xml":
#   ensure => file,
#   content => template('jenkins/jenkins-slave.xml.erb'),
#   require => File[ $slave_home ],
#   backup => false,
# }

# file { "${slave_home}/jenkins.slave.exe.config":
#   ensure => file,
#   content => template('jenkins/jenkins.slave.exe.config.erb'),
#   require => File[$slave_home],
#   backup => false,
# }
