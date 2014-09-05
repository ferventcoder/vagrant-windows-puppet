

class powershell {
  exec { 'Write $env:PATH':
    provider  => powershell,
    logoutput => true
  }
}

include powershell
