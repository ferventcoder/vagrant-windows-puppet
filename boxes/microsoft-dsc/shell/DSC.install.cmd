echo 'Setting up DSC components'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\SetupDSCComponents.ps1"
::would you believe the space after the equals is required?!
sc config wuauserv start= demand
