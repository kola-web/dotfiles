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

$env:STARSHIP_CONFIG = "$HOME\dotfiles\windows\starship.toml"
$env:YAZI_FILE_ONE="C:\Program Files\Git\usr\bin\file.exe"
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"
#$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"


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

function Invoke-Starship-PreCommand {
    # 修改窗口标题
    $currentDirectory = $pwd.Path
    $parentDirectory = Split-Path -Parent $currentDirectory
    $currentDirectoryName = Split-Path -Leaf $currentDirectory
    $parentDirectoryName = Split-Path -Leaf $parentDirectory
    $host.ui.RawUI.WindowTitle = "$parentDirectoryName\$currentDirectoryName `a"

    # 兼容 starship 分割窗口保留当前路径
    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
    if ($loc.Provider.Name -eq "FileSystem")
    {
      $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $host.ui.Write($prompt)
}

# https://learn.microsoft.com/zh-cn/windows/terminal/tutorials/new-tab-same-directory
#function prompt {
#  $loc = $executionContext.SessionState.Path.CurrentLocation;
#
#  $out = ""
#  if ($loc.Provider.Name -eq "FileSystem") {
#    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
#  }
#  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
#  return $out
#}


# plugin
#oh-my-posh init pwsh --config "$HOME/dotfiles/windows/kola.omp.json" | Invoke-Expression
Import-Module PSReadLine
Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -EditMode Vi
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
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle  InlineView

Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command
Set-PSReadlineKeyHandler -Chord "Ctrl+e" -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward

Invoke-Expression (& { (zoxide init powershell | Out-String) })


#if ( Test-Path '~/.inshellisense/pwsh/init.ps1' -PathType Leaf ) { . ~/.inshellisense/pwsh/init.ps1 } 

