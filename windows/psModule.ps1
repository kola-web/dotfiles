#Requires -RunAsAdministrator
#Requires -Version 7

# PowerShell Modules
$psModules = @(
    "PSReadLine"
)

# Install PS Modules
foreach ($psModule in $psModules) {
    if (!(Get-Module -ListAvailable -Name $psModule)) {
        Install-Module -Name $psModule -Force -AcceptLicense -Scope CurrentUser
    }
}
