# Function to source files if they exist
function zsh_add_file
    if test -f "$ZDOTDIR/$argv[1]"
        source "$ZDOTDIR/$argv[1]"
    end
end

function joshuto
    set -l ID (pid)
    mkdir -p /tmp/$USER
    set -l OUTPUT_FILE "/tmp/$USER/joshuto-cwd-$ID"
    env joshuto --output-file "$OUTPUT_FILE" $argv
    set -l exit_code $status

    switch $exit_code
        case 0
            # regular exit

        case 101
            # output contains current directory
            set JOSHUTO_CWD (cat "$OUTPUT_FILE")
            cd "$JOSHUTO_CWD"

        case 102
            # output selected files

        case '*'
            echo "Exit code: $exit_code"

    end
end

switch (uname -s)
    case Darwin
        # echo 'Mac OS X'

        if test -d /opt/homebrew/opt/ruby/bin
            set -x PATH /opt/homebrew/opt/ruby/bin $PATH
            set -x PATH (gem environment gemdir)/bin $PATH
        end


    case Linux
        # function proxy
        #     set windows_host (cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
        #     set -x ALL_PROXY "socks5://$windows_host:1090"
        #     set -x all_proxy $ALL_PROXY
        #     set -x http_proxy $all_proxy
        #     set -x https_proxy $all_proxy
        #     set -x ftp_proxy $all_proxy
        #     set -x HTTP_PROXY $all_proxy
        #     set -x HTTPS_PROXY $all_proxy
        #     set -x FTP_PROXY $all_proxy
        # end


    case "CYGWIN*","MINGW32*","MSYS*","MINGW*"
        # echo 'MS Windows'


    case '*'
        # echo 'Other OS'

end
