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

$env:YAZI_FILE_ONE="C:\Program Files\Git\usr\bin\file.exe"
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"
#Import-Module posh-git
#$omp_config = "C:\Users\l1556\dotfiles\windows\takuya.omp.json"
#oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange

Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Chord "Ctrl+e" -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward
#Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Putting the FUN in Functions 🎉
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Aliases 🔗
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Set-Alias -Name cat   -Value bat
Set-Alias -Name g     -Value lazygit
Set-Alias -Name r     -Value yy
Set-Alias -Name open  -Value explorer

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

function lnvim() {
  $env:NVIM_APPNAME="LazyVim"
  nvim $args
  $env:NVIM_APPNAME=""
}

# https://learn.microsoft.com/zh-cn/windows/terminal/tutorials/new-tab-same-directory
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}
