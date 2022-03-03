#!/bin/sh
export ZDOTDIR=$HOME/zsh
### ----------------------------------------------------- STTTING -----------------------------------------------------
unsetopt BEEP

### ----------------------------------------------------- EXPORT -----------------------------------------------------
export svn_editor=code
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="chrome"
export PATH=/Users/lijialin/.local/bin:$PATH

### ----------------------------------------------------- ALIAS -----------------------------------------------------
alias sudo="sudo -E"
# alias nvim=lvim
alias r="ranger"
alias s="neofetch"
alias ss="glances"
alias g="lazygit"
alias h="cheat"
alias brew='arch -arm64 /opt/homebrew/bin/brew'
alias python="/opt/homebrew/bin/python3"
alias proxy='export all_proxy=socks5://127.0.0.1:1090'
alias unproxy='unset all_proxy'
alias ls='logo-ls'
alias la='logo-ls -A'
alias ll='logo-ls -al'
alias lsg='logo-ls -D'
alias lag='logo-ls -AD'
alias llg='logo-ls -alD'
#$eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
eval "$(fnm env --use-on-cd)"

### ----------------------------------------------------- PROMPT -----------------------------------------------------
## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors
# enable only git
zstyle ':vcs_info:*' enable git
# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"
# format our main prompt for hostname current folder, and permissions.
PROMPT="%B%{$fg[blue]%}[%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%m%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT="%{$fg[green]%}%n@%m %~ %{$reset_color%}%#> "
PROMPT+="\$vcs_info_msg_0_ "
# TODO look into this for more colors
# https://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# also ascii escape codes

### ----------------------------------------------------- FUNCTION -----------------------------------------------------
# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}
function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}
function mach_java_mode() {
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

### ----------------------------------------------------- PLUGIN -----------------------------------------------------
zsh_add_plugin "jeffreytse/zsh-vi-mode"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "ajeetdsouza/zoxide"
zsh_add_completion "zsh-users/zsh-completions" false

### ----------------------------------------------------- ZOXIDE -----------------------------------------------------

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    \command zoxide add -- "$(__zoxide_pwd || \builtin true)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && [[ "$1" = '-' ]]; then
        if [[ -n "${OLDPWD}" ]]; then
            __zoxide_cd "${OLDPWD}"
        else
            # shellcheck disable=SC2016
            \builtin printf 'zoxide: $OLDPWD is not set'
            return 1
        fi
    elif [[ "$#" -eq 1 ]] && [[ -d "$1" ]]; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        result="$(\command zoxide query --exclude "$(__zoxide_pwd || \builtin true)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset() {
    \builtin unalias "$@" &>/dev/null || \builtin true
    \builtin unfunction "$@" &>/dev/null || \builtin true
    \builtin unset "$@" &>/dev/null
}
__zoxide_unset cd
function cd() {
    __zoxide_z "$@"
}
__zoxide_unset cdi
function cdi() {
    __zoxide_zi "$@"
}
if [[ -o zle ]]; then
    __zoxide_unset _cd
    function _cd() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return
        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]]; then
            \builtin local result
            # shellcheck disable=SC2086
            if result="$(\command zoxide query -i -- ${words[2,-1]})"; then
                __zoxide_result="${result}"
            else
                __zoxide_result=''
            fi
            \builtin printf '\e[5n'
        fi
    }
    __zoxide_unset _cd_helper
    function _cd_helper() {
        \builtin local result="${__zoxide_z_prefix}${__zoxide_result}"
        # shellcheck disable=SC2296
        [[ -n "${__zoxide_result}" ]] && LBUFFER="${LBUFFER}${(q-)result}"
        \builtin zle reset-prompt
    }
    \builtin zle -N _cd_helper
    \builtin bindkey "\e[0n" _cd_helper
    if [[ "${+functions[compdef]}" -ne 0 ]]; then
        \compdef -d cd
        \compdef _cd cd
    fi
fi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
# eval "$(zoxide init zsh)"

### ----------------------------------------------------- ZSH-VI-MODE -----------------------------------------------------
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
  ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
  ZVM_LAZY_KEYBINDINGS=false
}
source ~/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh

### ----------------------------------------------------- proxy -----------------------------------------------------
case "$(uname -s)" in
Darwin)
	# echo 'Mac OS X'
  export port=1090
  export host=127.0.0.1
	;;
Linux)
  # echo 'Linux'
  export port=1090
  export host=127.0.0.1
	;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
  sed -i "/.*ProxyCommand*/c\ ProxyCommand nc -v -x $host:$port %h %p" ~/.ssh/config
  export host=`cat /etc/resolv.conf|grep nameserver|awk'{print $2}'`
	;;
*)
	echo 'Other OS'
	;;
esac
function sp() {
    export ALL_PROXY=http://$host:$port
    export {http,https,ftp}_proxy=$ALL_PROXY
    export {HTTP,HTTPS,FTP}_PROXY=$ALL_PROXY
}
function rp() {
    unset {http,https,ftp}_proxy
    unset {HTTP,HTTPS,FTP}_PROXY
    unset ALL_PROXY
}
sp
