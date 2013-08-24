 package {'poshgit':
  ensure => latest,
  provider => 'chocolatey',
  source => 'c:\vagrant\resources\packages',
}