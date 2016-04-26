Write-Output 'Setting up DSC components'

if ($host.version.major -eq '5') {
  Write-Output "WMF 5 already installed"
  Exit 0
}

$wmfPath = 'c:\vagrantshared\resources\WMF'

$systemModules = "$env:ProgramFiles\WindowsPowerShell\Modules"
# Write-Host "Downloading the last available Resource Kit and unpacking to '$systemModules'"
# $resKitUrl = 'https://gallery.technet.microsoft.com/DSC-Resource-Kit-All-c449312d/file/131371/4/DSC%20Resource%20Kit%20Wave%2010%2004012015.zip'
# $resKitFile = 'reskit.zip'
# $resKitZip = Join-Path $wmfPath $resKitFile
# if (!(Test-Path $resKitZip)) {
#   Write-Output "Downloading `'$resKitUrl`' to `'$resKitZip`'"
#   (New-Object Net.WebClient).DownloadFile("$resKitUrl","$resKitZip")
# }
# $shellApplication = new-object -com shell.application
# $zipPackage = $shellApplication.NameSpace($resKitZip)
# $destinationFolder = $shellApplication.NameSpace($systemModules)
# $destinationFolder.CopyHere($zipPackage.Items(),0x14)

# Would you believe the space after the equals is required?!
cmd /c "sc config wuauserv start= demand"

# February 2015 WMF 5.0 Preview
$wmfDownloadUrl = 'http://download.microsoft.com/download/B/5/1/B5130F9A-6F07-481A-B4A6-CEDED7C96AE2/WindowsBlue-KB3037315-x64.msu'
#$wmfDownloadUrl = 'http://download.microsoft.com/download/B/5/1/B5130F9A-6F07-481A-B4A6-CEDED7C96AE2/Windows8-RT-KB3037667-x64.msu'
$wmfInstallerFile = 'WindowsBlue-KB3037315-x64.msu'
# April 2015 WMF 5.0 Preview
$wmfDownloadUrl = 'http://download.microsoft.com/download/4/9/6/496E0D89-F3B0-4FB0-B110-5F135C30325F/WindowsBlue-KB3055381-x64.msu'
$wmfInstallerFile = 'WindowsBlue-KB3055381-x64.msu'

#NOTE YOU HAVE TO SET THE WINDOWS SYSTEM BACK IN TIME TO USE THE ABOVE - Pick like June

# August 2015 Production Preview
$wmfDownloadUrl = 'https://download.microsoft.com/download/3/F/D/3FD04B49-26F9-4D9A-8C34-4533B9D5B020/Win8.1AndW2K12R2-KB3066437-x64.msu'
$wmfInstallerFile = 'Win8.1AndW2K12R2-KB3066437-x64.msu'

# WMF 5.0 Final
$wmfDownloadUrl = 'https://www.microsoft.com/en-us/download/confirmation.aspx?id=50395&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1'
$wmfInstallerFile = 'W2K12-KB3134759-x64.msu'

$wmfInstaller = Join-Path $wmfPath $wmfInstallerFile

if (!(Test-Path $wmfPath)) {
  Write-Output "Creating folder `'$wmfPath`'"
  $null = New-Item -Path "$wmfPath" -ItemType Directory
}

if (!(Test-Path $wmfInstaller)) {
  Write-Output "Downloading `'$wmfDownloadUrl`' to `'$wmfInstaller`'"
  (New-Object Net.WebClient).DownloadFile("$wmfDownloadUrl","$wmfInstaller")
}

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.WorkingDirectory = "$wmfPath"
$psi.FileName = "$wmfInstallerFile"
$psi.Arguments = "/quiet" # /norestart /log `'$wmfPath\wmfInstall.log`'"
#$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Minimized;

Write-Output "Installing `'$wmfInstaller`'"
$s = [System.Diagnostics.Process]::Start($psi);
$s.WaitForExit();
