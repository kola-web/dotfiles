# ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ████████╗███████╗
# ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
# ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║   ██║   ███████╗
# ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║   ██║   ╚════██║
# ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝   ██║   ███████║
#  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
# Profile.ps1 - Scott McKendry
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

$env:HTTP_PROXY="http://127.0.0.1:1080"
$env:HTTPS_PROXY="http://127.0.0.1:1080"

Import-Module posh-git
$omp_config = "C:\Users\l1556\dotfiles\windows\takuya.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadlineKeyHandler -Chord "Ctrl+e" -Function ForwardChar
Set-PSReadLineOption -PredictionSource History

# Putting the FUN in Functions 🎉
#Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Aliases 🔗
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Set-Alias -Name cat   -Value bat
Set-Alias -Name g     -Value lazygit
Set-Alias -Name r     -Value yazi
Set-Alias -Name open  -Value explorer

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
