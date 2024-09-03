#Requires -RunAsAdministrator
#Requires -Version 7

# Linked Files (Destination => Source)
$symlinks = @{
    $PROFILE                                                                                        = ".\windows\Profile.ps1"
    "$HOME\AppData\Local\nvim"                                                                      = ".\nvim\.config\nvim"
    "$HOME\.gitconfig"                                                                              = ".\git\.gitconfig"
    "$HOME\AppData\Roaming\lazygit"                                                                 = ".\lazygit\.config\lazygit"
    "$ENV:PROGRAMFILES\WezTerm\wezterm_modules"                                                     = ".\wezterm\.config\wezterm"
    #"$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" = ".\windowsterminal\settings.json"
}

# Create Symbolic Links
Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}
