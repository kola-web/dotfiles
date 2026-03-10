# ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ████████╗███████╗
# ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
# ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║   ██║   ███████╗
# ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║   ██║   ╚════██║
# ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝   ██║   ███████║
#  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
# Profile.ps1 - Scott McKendry
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

. "C:\Users\kola\api-key.ps1"

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

$env:STARSHIP_CONFIG = "$HOME\dotfiles\windows\starship.toml"
$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"
$env:HTTP_PROXY = "http://127.0.0.1:7897"
$env:HTTPS_PROXY = "http://127.0.0.1:7897"
$env:SVN_LOG_ENCODING = "utf-8"
$env:VOLTA_FEATURE_PNPM = 1
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
$env:EDITOR = "nvim"

# Aliases 🔗
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Set-Alias -Name cat   -Value bat
Set-Alias -Name g     -Value lazygit
Set-Alias -Name r     -Value yy
Set-Alias -Name open  -Value explorer
Set-Alias -Name ls    -Value Invoke-Eza
Set-Alias -Name qc -Value Run-QwenCode

function Run-QwenCode
{
  $env:HTTP_PROXY = ""
  $env:HTTPS_PROXY = ""
  qwen @args
}

# Utilities
function nvim_hosts
{
  nvim "C:\Windows\System32\drivers\etc\hosts"
}

function which ($command)
{
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function yy
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

function Script:Invoke-Eza
{
  eza $args --icons=auto
}

function lnvim()
{
  $env:NVIM_APPNAME = "LazyVim"
  nvim $args
  $env:NVIM_APPNAME = ""
}

function kickstart-nvim()
{
  $env:NVIM_APPNAME = "kickstart.nvim"
  nvim $args
  $env:NVIM_APPNAME = ""
}

function tnvim()
{
  $env:NVIM_APPNAME = "tnvim"
  nvim $args
  $env:NVIM_APPNAME = ""
}

function Invoke-Starship-PreCommand
{
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
# function prompt
# {
#   $loc = $executionContext.SessionState.Path.CurrentLocation;
#
#   $out = ""
#   if ($loc.Provider.Name -eq "FileSystem")
#   {
#     $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
#   }
#   $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
#   return $out
# }

Invoke-Expression (& starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-PSReadLineOption -EditMode Vi
$OnViModeChange = [scriptblock] {
  if ($args[0] -eq 'Command')
  {
    # Set the cursor to a blinking block.
    Write-Host -NoNewLine "`e[1 q"
  } else
  {
    # Set the cursor to a blinking line.
    Write-Host -NoNewLine "`e[5 q"
  }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command

Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle  InlineView

Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

Set-PSReadlineKeyHandler -Chord "Ctrl+e" -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward

# install: winget install fzf
# install: Install-Module -Name PSFzf
Import-Module PSFzf
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Import-Module PSCompletions
# $argc_scripts = $env:ARGC_COMPLETIONS_PATH -split [System.IO.Path]::PathSeparator | Get-ChildItem -File | ForEach-Object { $_.BaseName }
# $PSCompletions.argc_completions($argc_scripts)



