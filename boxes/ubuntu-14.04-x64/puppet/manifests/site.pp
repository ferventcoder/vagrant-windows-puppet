
node /^win2008r2x64.*$/ {

  package {'webpicmd':
    ensure => installed,
    provider => chocolatey,
    notify => Exec['netframework451'],
  }

  file {'c:/Temp':
    ensure => directory,
  }

  exec { 'netframework451':
      command   => 'C:\Chocolatey\bin\WebPiCmd.bat /Install /Products:NETFramework451 /SuppressReboot /AcceptEula /Log:C:\Temp\NETFramework451Log.htm',
      logoutput => true,
      timeout   => 900,
      cwd       => 'C:\Temp',
      unless    => 'C:\windows\system32\cmd.exe /c "C:\Chocolatey\bin\WebPiCmd.bat /List /ListOption:Installed | findstr.exe NETFramework451"',
      returns   => [0,194],
      require   => File['c:/Temp']
  }

}
