case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
    }
  }
}

#include chocolatey

# class {'chocolatey':
#   log_output              => true,
# }
class {'chocolatey':
  chocolatey_download_url => 'file:///c:/code/temp/chocolatey.0.9.9.10.nupkg',
  use_7zip                => false,
  log_output              => true,
}
#include chocolatey_server


# chocolatey_source {'local':
#   ensure    => 'present',
#   location  => 'http://localhost/chocolatey'
# }

package {'roundhouse':
  ensure   => '0.8.6',
}

#->

# package {'putty':
#   ensure   => installed,
# } ->

# package {'launchy':
#   ensure   => latest,
# }
# ->

# chocolatey::source {'chocolatey':
#   enable => false,
# }
