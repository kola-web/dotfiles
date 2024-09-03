#Requires -RunAsAdministrator
#Requires -Version 7

# Winget dependencies
$wingetDeps = @(
    "eza-community.eza"
    "ezwinports.make"
    "kitware.cmake"
    "fastfetch-cli.fastfetch"
    "gerardog.gsudo"
    "git.git"
    "github.cli"
    "microsoft.powershell"
    "neovim.neovim"
    "starship.starship"
    "microsoft.windowsterminal"
    "junegunn.fzf"
    "ajeetdsouza.zoxide"
    "jesseDuffield.lazygit"
)

Write-Host "Installing missing dependencies..."
$installedWingetDeps = winget list | Out-String
foreach ($wingetDep in $wingetDeps) {
    if ($installedWingetDeps -notmatch $wingetDep) {
        winget install --id $wingetDep
    }
}
