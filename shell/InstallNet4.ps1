$WebPIPath = 'c:\temp\webpi'

function Is64Bit {  [IntPtr]::Size -eq 8  }

function Enable-Net40 {
    if(Is64Bit) {$fx="framework64"} else {$fx="framework"}
    if(!(test-path "$env:windir\Microsoft.Net\$fx\v4.0.30319")) {
        $env:chocolateyPackageFolder="$env:temp\chocolatey\webcmd"
        Install-ChocolateyZipPackage 'webcmd' 'http://www.iis.net/community/files/webpi/webpicmdline_anycpu.zip' "$WebPIPath"
        & "$WebPIPath\WebpiCmdLine.exe" /products: NetFramework4 /accepteula
    }
}

if ($env:ChocolateyInstall -eq $null) {$env:ChocolateyInstall = "c:\chocolatey"}

Import-Module "c:\chocolatey\chocolateyinstall\helpers\chocolateyInstaller.psm1"
Enable-Net40
if (test-path($WebPIPath)) {
    Remove-Item -Recurse -Force "$WebPIPath"
}