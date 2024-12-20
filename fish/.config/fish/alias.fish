alias e='neofetch'
alias f='zi'
# alias r='TERM=screen-256color ranger'
# alias r='ranger'
alias r='joshuto'
alias g='lazygit'
alias lzd='lazydocker'
alias zsh-update-plugins="find ""$ZDOTDIR"/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'

# NVIM_APPNAME
# alias nvim="NVIM_APPNAME=nvim nvim"
alias lnvim="NVIM_APPNAME=LazyVim nvim"
alias nnvim="NVIM_APPNAME=NvChad nvim"
alias nvim-dot="NVIM_APPNAME=nvim-dot nvim"

# exa
if command -v "eza" >/dev/null
    alias ls='eza --icons'
end

switch (uname -s)
    case "Darwin"
        # echo 'Mac OS X'
        # alias ls='ls -G'
        ;;
    case "Linux"
        # alias ls='ls --color=auto'
        alias open 'nautilus'
        ;;
    case "CYGWIN*","MINGW32*","MSYS*","MINGW*"
        # echo 'MS Windows'
        ;;
    case '*'
        # echo 'Other OS'
        ;;
end
