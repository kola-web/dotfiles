if not set -q WSL_DISTRO_NAME
    return
end

if test -d /home/linuxbrew/.linuxbrew/bin
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

set -gx CAROOT /mnt/c/Users/kola/AppData/Local/mkcert

abbr open 'explorer.exe'

function storePathForWindowsTerminal --on-variable PWD
    if test -n "$WT_SESSION"
        printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
    end
end
