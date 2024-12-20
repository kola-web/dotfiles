# ---- system -----------------------------------------
switch (uname -s)
    case "Darwin"
        # echo 'Mac OS X'
        set -x PATH /Users/lijialin/.local/bin $PATH
        set -x PATH /Users/lijialin/.cargo/bin $PATH
        set -x PATH /opt/homebrew/bin $PATH
        set -x PATH "/opt/homebrew/sbin" $PATH
        set -x PATH "/opt/homebrew/opt/curl/bin" $PATH
        set -x PATH "/Users/lijialin/Library/Rime/plum" $PATH
        set -x PATH /opt/local/bin $PATH
        set -x PATH /opt/local/sbin $PATH
        set -x N_PREFIX $HOME/.n
        set -x PATH $N_PREFIX/bin $PATH
        # set -x PATH "/opt/homebrew/opt/sqlite/bin" $PATH
        # set -x PNPM_HOME "/Users/lijialin/.config/pnpm"
        # contains_path $PNPM_HOME $PATH; or set -x PATH $PNPM_HOME $PATH
        ;;

    case "Linux"
        set hostip (cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
        alias www "https_proxy=\"http://$hostip:8080\" http_proxy=\"http://$hostip:8080\""

        # or set it global
        set hostip (cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
        set -x https_proxy "http://$hostip:1080"
        set -x http_proxy "http://$hostip:1080"
        set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
        ;;

    case "CYGWIN*","MINGW32*","MSYS*","MINGW*"
        # echo 'MS Windows'
        ;;

    case '*'
        # echo 'Other OS'
        ;;
end

# set -x LC_ALL C
set -x PATH "$HOME/.local/bin" $PATH
set -x PATH "$HOME/.local/share/neovim/bin" $PATH
