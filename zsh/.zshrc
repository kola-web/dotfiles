# 公司wifi密码 qweasdzxc888
#!/bin/sh
source ~/.config/zsh/.zprezto/runcoms/zshrc
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory
### ----------------------------------------------------- STTTING -----------------------------------------------------
unsetopt BEEP
setopt HIST_IGNORE_ALL_DUPS
bindkey -v

### ----------------------------------------------------- PROXY -----------------------------------------------------
function proxy() {
    export ALL_PROXY=socks5://127.0.0.1:1090
    export all_proxy=$ALL_PROXY
    # export {http,https,ftp}_proxy=http://127.0.0.1:41091
    # export {HTTP,HTTPS,FTP}_PROXY=https://127.0.0.1:41091
}
function unproxy() {
    # unset {http,https,ftp}_proxy
    # unset {HTTP,HTTPS,FTP}_PROXY
    unset ALL_PROXY
    unset all_proxy
}
proxy


### ----------------------------------------------------- EXPORT -----------------------------------------------------
# export all_proxy=socks5://127.0.0.1:1090
export svn_editor=code
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="chrome"
export PATH=/Users/lijialin/.local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/Users/lijialin/.cargo/bin:$PATH

### ----------------------------------------------------- ALIAS -----------------------------------------------------
alias sudo="sudo -E"
# alias nvim=lvim
alias r="ranger"
alias s="neofetch"
alias ss="glances"
alias g="lazygit"
alias h="cheat"
alias f="fzf"
alias brew='arch -arm64 /opt/homebrew/bin/brew'
alias ls='logo-ls'
alias la='logo-ls -A'
alias ll='logo-ls -al'
alias lsg='logo-ls -D'
alias lag='logo-ls -AD'
alias llg='logo-ls -alD'
alias d='duf'
alias ds='dust'
alias b='btop'

### ----------------------------------------------------- function -----------------------------------------------------
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


### ----------------------------------------------------- eval -----------------------------------------------------
eval "$(fnm env --use-on-cd)"
# eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

### ----------------------------------------------------- plugin -----------------------------------------------------
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
