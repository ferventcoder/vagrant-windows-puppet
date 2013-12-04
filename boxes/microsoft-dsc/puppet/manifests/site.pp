# Package {
#   ensure => latest,
#   provider => chocolatey,
# }

# VS dev tools
# package {['SQLManagementStudio'
#     ,'SQLExpressTools'
#     ,'VWD_RTW'
#     ,'VWD2010SP1AzurePack'
#     ,'MVC3'
#     ,'MVC3Loc'
#     ]:
#   ensure => installed,
#   provider => chocolatey,
#   source => "webpi"
# }

# IIS
# package {['ASPNET'
#     ,'ASPNET_REGIIS'
#     ,'DefaultDocument'
#     ,'DynamicContentCompression'
#     ,'HTTPRedirection'
#     ,'IIS7_ExtensionLessURLS'
#     ,'IISExpress'
#     ,'IISExpress_7_5'
#     ,'IISManagementConsole'
#     ,'ISAPIExtensions'
#     ,'NetExtensibility'
#     ,'RequestFiltering'
#     ,'StaticContent'
#     ,'StaticContentCompression'
#     ,'UrlRewrite2'
#     ,'WindowsAuthentication'
#     ]:
#   ensure => installed,
#   provider => chocolatey,
#   source => "webpi"
# }

#,'PowerGuiVSX'

package {'disableuac':
  ensure => latest,
  provider => chocolatey,
} ->
package {['SublimeText2.app'
    ,'notepadplusplus'
    ,'fiddler'
    ,'sysinternals'
    ,'poshgit'
    ,'gitextensions'
    ,'growl'
    ,'conemu'
    ,'powergui'
    ,'pester'
    ,'psget'
    ]:
  ensure => latest,
  provider => chocolatey,
  notify => Package['powershell4'],
}

package {'powershell4':
  ensure => latest,
  provider => chocolatey,
  notify => Package['vagrant-winrm-config'],
}

package {'vagrant-winrm-config':
  ensure => latest,
  provider => chocolatey,
}
