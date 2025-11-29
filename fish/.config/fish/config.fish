# 简单别名 (推荐 abbr，适合命令行快速输入，可自动补全)
abbr e fastfetch
abbr f zi
abbr r yy # yazi
alias g lazygit
abbr lzd lazydocker
abbr nvimrc 'nvim ~/.config/nvim/'
abbr ls 'eza --icons'

abbr lnvim 'env NVIM_APPNAME=LazyVim nvim'
abbr nnvim 'env NVIM_APPNAME=NvChad nvim'
abbr tnvim 'env NVIM_APPNAME=NativeVim nvim'

# 或者：如果需要能在脚本里用，可以用 function 实现（见上一条回答）

# 环境变量和 PATH 设置
set -gx VOLTA_FEATURE_PNPM 1
set -gx VOLTA_HOME $HOME/.volta
# Fish 设置 PATH 推荐 prepend（注意顺序）
set -gx PATH $VOLTA_HOME/bin $HOME/.local/bin $HOME/.local/share/neovim/bin $PATH

zoxide init fish | source
starship init fish | source
