[DscLocalConfigurationManager()]
Configuration Debug {
    Node localhost {
       Settings {
           DebugMode = 'All' #None, ForceModuleImport, All, ResourceScriptBreakAll
       }
    }
}

Debug

$CimSession = New-CimSession -ComputerName localhost
Set-DscLocalConfigurationManager -Path .\Debug -CimSession $CimSession

# LocalConfigurationManager
# {
#     DebugMode = $true
# }
