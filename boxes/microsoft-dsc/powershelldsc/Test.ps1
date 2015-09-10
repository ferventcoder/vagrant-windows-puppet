Configuration TestConfig {

  Node "localhost" {
  # http://technet.microsoft.com/en-us/library/dn249921.aspx - Built in DSC Resources
  # another good resource: http://readsource.co.uk/blog/2013/7/9/using-powershell-dsc-script-resource-provider

  # Requires looks like this: Requires = "[File]DirectoryCopy" when File DirectoryCopy {}

  # http://technet.microsoft.com/en-us/library/dn249917.aspx
    # Archive [string] #ResourceName
    # {
    #     DestinationPath = [string]
    #     Path = [string]
    #     [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ Requires = [string[]] ]
    #     [ Validate = [bool]  {$true | $false } ]
    # }

    Archive ArchiveTest {
      Ensure = "Present"
      Path = "C:\powershelldsc\test.zip"
      Destination = "C:\testdsc"
      Checksum = ModifiedDate
      Validate = $true
    }

  # http://technet.microsoft.com/en-us/library/dn282121.aspx
    # Environment [string] #ResourceName
    # {
    #     Name = [string]
    #     [ Ensure = [string] { Absent | Present } ]
    #     [ Path = [bool]  {$true | $false } ]
    #     [ Requires = [string[]] ]
    #     [ Value = [string] ]
    # }

    Environment TestPath {
      Ensure = "Present"
      Name = "TestEnv"
      Path = $false
      Value = "Test"
    }

  # http://technet.microsoft.com/en-us/library/dn282129.aspx
    # File [string] #ResourceName
    # {
    #     DestinationPath = [string]
    #     [ Attributes = [string[]] ]
    #     [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    #     [ Contents = [string] ]
    #     [ Credential = [CimInstance] ]
    #     [ Ensure = [string]  { Absent | Present } ]
    #     [ Force = [bool] {$true | $false } ]
    #     [ Recurse = [bool] {$true | $false }  ]
    #     [ Requires = [string[]] ]
    #     [ SourcePath = [string] ]
    #     [ Type = [string] { File | Directory } ]
    #     [ MatchSource = [bool] {$true | $false } ]
    # }

    File TestFile {
      Ensure = "Present"
      Contents = "Hi! testcontent"
      DestinationPath = "c:\testdsc\test.txt"
    }
    # notes - weird, this still validates the contents are the same with no checksum

    File TestDirectory {
      Ensure = "Present"
      Type = "Directory"
      DestinationPath = "c:\testdsc\test"
    }

  # http://technet.microsoft.com/en-us/library/dn282124.aspx
    # Group [string] #ResourceName
    # {
    #     Name = [string]
    #     [ Credential = [CimInstance] ]
    #     [ Description = [string] ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ Members = [string[]] ]
    #     [ MembersToExclude = [string[]] ]
    #     [ MembersToInclude = [string[]] ]
    #     [ Requires = [string[]] ]
    # }

    Group TestUsers {
      Ensure = "Present"
      Name = "TestUsers"
      Members = @("Administrator")
    }

  # http://technet.microsoft.com/en-us/library/dn282117.aspx
    # Log [string] #ResourceName
    # {
    #     Message = [string]
    #     [ Requires = [string[]] ]
    # }

    Log LogTest {
      Message = "Test"
    }

  # http://technet.microsoft.com/en-us/library/dn282132.aspx
    # Package [string] #ResourceName
    # {
    #     Name = [string]
    #     Path = [string]
    #     ProductId = [string] ##why is this required???? AND IT HAS TO BE GUID
    #     [ Arguments = [string] ]
    #     [ Credential = [CimInstance] ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ LogPath = [string] ]
    #     [ Requires = [string[]] ]
    #     [ ReturnCode = [UInt32[]] ] ##defaults?
    # }

    # Package Putty {
    #   Ensure = "Present"
    #   Name = "Putty"
    #   Path = "C:\powershelldsc\putty-0.63-installer.exe"
    #   ProductId = "PuTTY_is1"
    #   Arguments = "/VERYSILENT"
    #   ReturnCode = @(0,3010)
    # }
    #ProductId is required to be a GUID, so this is a NOPE

  # http://technet.microsoft.com/en-us/library/dn282123.aspx
    # WindowsProcess [string] #ResourceName
    # {
    #     Arguments = [string]
    #     Path = [string]
    #     [ Credential = [CimInstance] ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ Requires = [string[]] ]
    #     [ StandardErrorPath = [string] ]
    #     [ StandardInputPath = [string] ]
    #     [ StandardOutputPath = [string] ]
    #     [ WorkingDirectory = [string] ]
    # }
    WindowsProcess ChocolateyList {
      Ensure = "Present"
      Arguments = "list -lo"
      Path = "C:\Chocolatey\chocolateyinstall\chocolatey.cmd"
      StandardOutputPath = "c:\testdsc\choco_list_output.log"
    }

    # FAILS (even though it actually runs)
    # VERBOSE: [WIN2008R2X64]: LCM:  [ Start  Set      ]
    # VERBOSE: [WIN2008R2X64]: LCM:  [ Start  Resource ]  [[WindowsProcess]ChocolateyList]
    # VERBOSE: [WIN2008R2X64]: LCM:  [ Start  Test     ]  [[WindowsProcess]ChocolateyList]
    # VERBOSE: [WIN2008R2X64]: LCM:  [ End    Test     ]  [[WindowsProcess]ChocolateyList]  in 0.1250 seconds.
    # VERBOSE: [WIN2008R2X64]: LCM:  [ Start  Set      ]  [[WindowsProcess]ChocolateyList]
    # VERBOSE: [WIN2008R2X64]:                            [[WindowsProcess]ChocolateyList] Process matching path 'C:\Chocolatey\chocola
    # teyinstall\chocolatey.cmd' started
    # VERBOSE: [WIN2008R2X64]:                            [[WindowsProcess]ChocolateyList] Failure starting process matching path 'C:\C
    # hocolatey\chocolateyinstall\chocolatey.cmd'. Message: "Failed to wait for processes to start".
    # VERBOSE: [WIN2008R2X64]: LCM:  [ End    Set      ]  [[WindowsProcess]ChocolateyList]  in 2.1670 seconds.
    # PowerShell provider MSFT_ProcessResource  failed to execute Set-TargetResource functionality with error message: Failure
    # starting process matching path 'C:\Chocolatey\chocolateyinstall\chocolatey.cmd'. Message: "Failed to wait for processes to
    # start".
    #     + CategoryInfo          : InvalidOperation: (:) [], CimException
    #     + FullyQualifiedErrorId : ProviderOperationExecutionFailure
    #     + PSComputerName        : localhost


  # http://technet.microsoft.com/en-us/library/dn282133.aspx
    # Registry [string] #ResourceName
    # {
    #     Key = [string]
    #     ValueName = [string]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ Hex = [bool] {$true | $false } ]
    #     [ Requires = [string[]] ]
    #     [ ValueData = [string[]] ]
    #     [ ValueType = [string] { Binary | Dword | ExpandString | MultiString | Qword | String }  ]
    # }

    Registry DisableUAC {
      Ensure = "Present"
      Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
      ValueName = "EnableLUA"
      ValueData = "0"
      ValueType = "Dword"
    }

  # http://technet.microsoft.com/en-us/library/dn282127.aspx
    # WindowsFeature [string] #ResourceName
    # {
    #     Name = [string]
    #     [ Credential = [CimInstance] ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ IncludeAllSubFeature = [bool] {$true | $false } ]
    #     [ LogPath = [string] ]
    #     [ Requires = [string[]] ]
    #     [ Source = [string] ]
    # }

    WindowsFeature IIS {
      Ensure ="Present"
      Name = "Web-Server"
    }

    # WindowsFeature ASPNET {
    #   Ensure = "Present"
    #   Name = "Web-Asp-Net45"
    # }

  # http://technet.microsoft.com/en-us/library/dn282130.aspx
    # Script [string] #ResourceName
    # {
    #     GetScript = [string]
    #     SetScript = [string]
    #     TestScript = [string]
    #     [ Credential = [CimInstance] ]
    #     [ Requires = [string[]] ]
    # }

    # Script TestScript {
    #   SetScript = {
    #     $sw = New-Object System.IO.StreamWriter("C:\testdsc\TestFile.txt")
    #     $sw.WriteLine("Some sample string")
    #     $sw.Close()
    #   }
    #   TestScript = { Test-Path "C:\testdsc\TestFile.txt" }
    #   GetScript = {"some hash table"}
    # }

    #FAILS
    # This needs better documentation and examples for the required GetScript.

  # http://technet.microsoft.com/en-us/library/dn282120.aspx
    # Service [string] #ResourceName
    # {
    #     Name = [string]
    #     [ Ensure = [string] { Absent | Present } ] ##this is old and bad
    #     [ BuiltInAccount = [string] { LocalService | LocalSystem | NetworkService }  ]
    #     [ Credential = [CimInstance] ]
    #     [ Requires = [string[]] ]
    #     [ Arguments = [string[]] ]
    #     [ StartupType = [string] { Automatic | Disabled | Manual }  ]
    #     [ Status = [string] { Start | Stop | Restart | Pause | Resume }  ] ##this is old and bad
    #     [ State = [string] { Running | Stopped } ]
    # }

    Service BITSTest  {
      Name = "BITS"
      BuiltInAccount = "LocalSystem"
      StartupType = "Manual"
      State = "Stopped"
    }

  # http://technet.microsoft.com/en-us/library/dn282118.aspx
    # User [string] #ResourceName
    # {
    #     UserName = [string]
    #     [ Description = [string] ]
    #     [ Disabled = [bool] {$true | $false } ]
    #     [ Ensure = [string] { Absent | Present }  ]
    #     [ FullName = [string] ]
    #     [ Password = [CimInstance] ]
    #     [ PasswordChangeNotAllowed = [bool] {$true | $false } ]
    #     [ PasswordChangeRequired = [bool] {$true | $false } ]
    #     [ PasswordNeverExpires = [bool] {$true | $false } ]
    #     [ Requires = [string[]] ]
    # }

    User vagrant {
      Ensure ="Present"
      UserName = "vagrant"
    }

 }
}

TestConfig
Sleep 1
#Get-DscLocalConfigurationManager
#Set-DscLocalConfigurationManager -Path .\TestConfig -ComputerName "localhost"
#Get-DscResource -Name Service -Syntax

#Test-DscConfiguration -Verbose
#Get-DscConfiguration -Verbose
Start-DscConfiguration -Wait -Verbose -Path .\TestConfig #-WhatIf
