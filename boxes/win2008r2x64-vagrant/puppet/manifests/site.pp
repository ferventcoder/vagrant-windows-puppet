 package {'poshgit':
  ensure => latest,
  provider => 'chocolatey',
  source => 'c:\vagrant\resources\packages;http://chocolatey.org/api/v2/',
}