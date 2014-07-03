$ChocoInstallPathOld = "$env:SystemDrive\Chocolatey\bin"
$ChocoInstallPath = "$env:SystemDrive\ProgramData\Chocolatey\bin"

Set-ExecutionPolicy Unrestricted
$DebugPreference = "Continue";
$env:ChocolateyEnvironmentDebug = 'true'

# Put chocolatey on the MACHINE path, vagrant does not have access to user environment variables
$envPath = $env:PATH
if (!$envPath.ToLower().Contains($ChocoInstallPath.ToLower())) {

  Write-Host "PATH environment variable does not have `'$ChocoInstallPath`' in it. Adding..."
  $ActualPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
  $StatementTerminator = ";"
  $HasStatementTerminator = $ActualPath -ne $null -and $ActualPath.EndsWith($StatementTerminator)
  If (!$HasStatementTerminator -and $ActualPath -ne $null) {$ChocoInstallPath = $StatementTerminator + $ChocoInstallPath}
  if (!$ChocoInstallPath.EndsWith($StatementTerminator)) {$ChocoInstallPath += $StatementTerminator}

  [Environment]::SetEnvironmentVariable('Path', $ActualPath + $ChocoInstallPath, [System.EnvironmentVariableTarget]::Machine)
}

$env:Path += ";$ChocoInstallPath;$ChocoInstallPathOld"

if (!(Test-Path $ChocoInstallPath)) {
  $resourcesPath = 'c:\vagrant\resources'
  $chocoPkgFolder = get-childitem $resourcesPath -recurse -include 'chocolatey.*' | select -First 1

  if ($chocoPkgFolder -ne $null) {
    # Run a completely offline install if everything is downloaded
    Write-Host "Installing chocolatey on this machine"
    $toolsFolder = Join-Path $chocoPkgFolder "tools"
    $chocInstallPS1 = Join-Path $toolsFolder "chocolateyInstall.ps1"

    & $chocInstallPS1
  } else {
    iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))
    cinst chocolatey -pre
  }
} else {
  Write-Host "Nothing to do. Chocolatey already ready."
}
