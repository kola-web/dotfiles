#Requires -RunAsAdministrator
#Requires -Version 7

winget import -i ./windows/winget-pkgs.json --ignore-unavailable --ignore-versions
