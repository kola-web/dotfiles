#Requires -RunAsAdministrator
#Requires -Version 7

# Winget dependencies
$wingetDeps = @(
    "sharkdp.bat"
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
    "wez.wezterm"
    "7zip.7zip"
    "BurntSushi.ripgrep.MSVC"
    "ClashVergeRev.ClashVergeRev"
    "Git.Git"
    "Pylogmon.pot"
    "GitHub.cli"
    "Neovim.Neovim"
    "Volta.Volta"
    "glzr-io.zebar"
    "glzr-io.glazewm"
    "wez.wezterm"
    "Starship.Starship"
    "Microsoft.PowerShell"
    "DEVCOM.LuaJIT"
    "gerardog.gsudo"
    "TortoiseSVN.TortoiseSVN"
    "Kitware.CMake"
    "Google.Chrome.EXE"
    "Tencent.QQMusic"
    "Tencent.WeChat"
    "Rime.Weasel"
    "Python.Launcher"
    "DEVCOM.JetBrainsMonoNerdFont"
    "AutoHotkey.AutoHotkey"
    "JesseDuffield.lazygit"
    "JanDeDobbeleer.OhMyPosh"
    "ajeetdsouza.zoxide"
    "eza-community.eza"
    "ezwinports.make"
    "jqlang.jq"
    "junegunn.fzf"
    "sharkdp.fd"
    "sxyazi.yazi"
    "zig.zig"
    "ImageMagick.ImageMagick"
    "Microsoft.VisualStudio.2022.Community"
    "Notion.Notion"
)

Write-Host "Installing missing dependencies..."
$installedWingetDeps = winget list | Out-String
foreach ($wingetDep in $wingetDeps) {
    if ($installedWingetDeps -notmatch $wingetDep) {
        winget install --id $wingetDep
    }
}
