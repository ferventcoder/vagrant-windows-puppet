case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
    }
  }
}

include chocolatey

package {'roundhouse':
  ensure   => '0.8.5.0',
}

package {'putty':
  ensure   => installed,
}

package {'launchy':
  ensure   => latest,
}