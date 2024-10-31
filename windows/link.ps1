#Requires -RunAsAdministrator
#Requires -Version 7

# Linked Files (Destination => Source)
$symlinks = @{
    $PROFILE                                                                                         = ".\windows\Profile.ps1"
    "$HOME\AppData\Local\nvim"                                                                       = ".\nvim\.config\nvim"
    "$HOME\.gitconfig"                                                                               = ".\git\.gitconfig"
    "$HOME\AppData\Roaming\lazygit"                                                                  = ".\lazygit\.config\lazygit"
    "$HOME\.config\wezterm"                                                                          = ".\wezterm\.config\wezterm"
    "$HOME\.glzr"                                                                                    = ".\glzr"
    "$HOME\AppData\Roaming\alacritty"                                                                = ".\alacritty\.config\alacritty"
    "$HOME\AppData\Roaming\neovide"                                                                  = ".\neovide\.config\neovide"
    "$HOME\AppData\Roaming\yazi\config"                                                              = ".\yazi\.config\yazi"
    "$HOME\AppData\Roaming\nushell"                                                                  = ".\nushell\.config\nushell"
    #"$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" = ".\windowsterminal\settings.json"
}

# Create Symbolic Links
Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}

