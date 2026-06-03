#!/bin/sh

# +---------+
# | BASE |
# +---------+

unsetopt BEEP                    # beeping is annoying

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

zsh_add_file "zsh-zimfw"
zsh_add_file "zsh-prompt"
zsh_add_file "scripts/completion.zsh"


# +------------+
# | COMPLETION |
# +------------+

alias e='fastfetch'
alias f='zi'
# alias r='TERM=screen-256color ranger'
# alias r='ranger'
alias r='yy' # yazi
alias g='lazygit'
alias lzd='lazydocker'
alias nvimrc='nvim ~/.config/nvim/'
alias ls='eza --icons'

# NVIM_APPNAME
alias lnvim="NVIM_APPNAME=LazyVim nvim"
alias nnvim="NVIM_APPNAME=NvChad nvim"
alias tnvim="NVIM_APPNAME=NativeVim nvim"

export VOLTA_FEATURE_PNPM=1
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH

eval "$(zoxide init zsh)"
