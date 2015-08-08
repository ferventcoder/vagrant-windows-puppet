case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      source   => 'C:\vagrant\resources\packages',
    }
  }
}

include chocolateyserver

# package {'roundhouse':
#   ensure   => '0.8.5.0',
# }

# package {'roundhouse':
#   ensure   => latest,
# }

# package {'roundhouse':
#   ensure   => installed,
# }

# package {'roundhouse':
#   ensure   => absent,
# }

# package {'badpackage':
#   ensure => '1.0',
#   #install_options => ['--skip-powershell']
# }

# package {'badpackage':
#   ensure => latest,
#   #install_options => ['--skip-powershell']
# }

# package {'git.install':
#   ensure   => installed,
# }

# # package {'notepadplusplus.commandline':
# #   ensure   => installed,
# # }

# package {'putty':
#   ensure   => installed,
#   source => 'https://chocolatey.org/api/v2/'
# }

# package {'launchy':
#   ensure   => latest,
#   install_options => "-override -installArgs '/VERYSILENT /NORESTART",
# }
