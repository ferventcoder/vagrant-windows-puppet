case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      source   => 'C:\vagrant\resources\packages',
    }
  }
}

# this contains the bits to install the custom server
#include chocolateyserver

package {'roundhouse':
  ensure   => '0.8.5.0',
}

package {'notepadplusplus.commandline':
  ensure   => installed,
}

package {'putty':
  ensure   => installed,
}

package {'launchy':
  ensure   => installed,
  # install_options => "-override -installArgs '/VERYSILENT /NORESTART",
}

# package {'nugetpackageexplorer':
#   ensure => installed,
#   source => 'https://chocolatey.org/api/v2/',
# }

# package {'ChocolateyGUI':
#   ensure          => installed,
#   install_options => "-ignoreDependencies -override -installArgs '/quiet'",
# }
