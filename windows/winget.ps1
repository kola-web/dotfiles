#Requires -RunAsAdministrator
#Requires -Version 7

winget import -i ./winget-pkgs.json --ignore-unavailable --ignore-versions
