if not test (uname) = Darwin
    return
end

# PATH 相关
set -gx PATH /Users/lijialin/.local/bin $PATH
set -gx PATH /Users/lijialin/.cargo/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /opt/homebrew/opt/curl/bin $PATH
set -gx PATH /Users/lijialin/Library/Rime/plum $PATH
set -gx PATH /opt/local/bin $PATH
set -gx PATH /opt/local/sbin $PATH
set -gx N_PREFIX $HOME/.n
set -gx PATH $N_PREFIX/bin $PATH
set -gx PNPM_HOME /Users/lijialin/Library/pnpm

# 判断 ruby bin 目录
if test -d /opt/homebrew/opt/ruby/bin
    set -gx PATH /opt/homebrew/opt/ruby/bin $PATH
    set gem_bin (gem environment gemdir)/bin
    set -gx PATH $gem_bin $PATH
end
