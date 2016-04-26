case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      #source   => 'C:\vagrant\resources\packages',
    }
  }
}

include chocolatey
# or
# class {'chocolatey':
#   chocolatey_download_url => 'file:///C:/vagrant/resources/packages/chocolatey.0.9.9.11.nupkg',
#   use_7zip                => false,
#   log_output              => true,
# }

exec { 'Write Path':
  command   => 'Write-Output $env:PATH',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Posh Location':
  command   => 'get-process powershell* | %{ Write-Host $($_.Path)}',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Path exit 0':
  command   => 'Write-Output $env:PATH; exit 0',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Path unless 1':
  command   => 'Write-Output $env:PATH; exit 0',
  unless    => 'Write-Output "Yo"; exit 1',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Path unless 0':
  command   => 'Write-Output $env:PATH; exit 0',
  unless    => 'Write-Output "Yo"; exit 0',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Path onlyif 1':
  command   => 'Write-Output $env:PATH; exit 0',
  onlyif    => 'Write-Output "Yo"; exit 1',
  provider  => powershell,
  logoutput => true
}

exec { 'Write Path onlyif 0':
  command   => 'Write-Output $env:PATH; exit 0',
  onlyif    => 'Write-Output "Yo"; exit 0',
  provider  => powershell,
  logoutput => true
}

exec { 'Set Temp Env':
  command   => '$env:PATHTEMP="123"',
  provider  => powershell,
  logoutput => true
} ->

exec { 'Write Temp Env':
  command   => 'Write-Output "PATHTEMP=$($env:PATHTEMP) (should be empty)"',
  provider  => powershell,
  logoutput => true
}

# add windows features
windowsfeature { 'Web-WebServer':
} ->
windowsfeature { 'Web-Asp-Net':
} ->

# remove default web site
iis::manage_site {'Default Web Site':
  ensure        => absent,
  site_path     => 'any',
  app_pool      => 'DefaultAppPool'
} ->

# application in iis
iis::manage_app_pool { 'newpool':
  enable_32_bit           => true,
  managed_runtime_version => 'v4.0',
} ->
iis::manage_site {'The Server':
  site_path     => 'c:/inetpub/wwwroot',
  port          => "80",
  ip_address    => '*',
  app_pool      => "newpool",
}


# package {'windirstat':
#   ensure => installed,
#   #ensure => absent,
#   # install_options => ['-override', '-installArgs', '"', '/VERYSILENT', '/NORESTART', '"']
# }
