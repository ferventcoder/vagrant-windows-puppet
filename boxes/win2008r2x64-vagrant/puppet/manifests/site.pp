

package {'git.install':
  ensure => '1.8.1.2',
  provider => 'chocolatey',
  #install_options => '-source c:\vagrant\resources\packages',
  source => 'c:\vagrant\resources\packages',
}
