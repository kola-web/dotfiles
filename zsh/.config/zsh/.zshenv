#!/bin/bash

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000
export ZIM_HOME=$ZDOTDIR/.zim

# Man pages
export MANPAGER='nvim +Man!'

source "$ZDOTDIR/zsh-functions"

os=$(uname)

if [[ $os == "Darwin" ]]; then
    # 这里可以添加 macOS 特有的操作
    zsh_add_file "system/zsh-macos"
fi

if [[ $os == "Linux" && ! -f "$(command -v wslpath)"  ]]; then
    # 这里可以添加 linux 特有的操作
    zsh_add_file "system/zsh-linux"
fi

if [[ $os == "Linux" &&  -f "$(command -v wslpath)"  ]]; then
    # 这里可以添加 wsl 特有的操作
    zsh_add_file "system/zsh-wsl"
fi

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF_COLORS="bg+:-1,\
# fg:gray,\
# fg+:white,\
# border:black,\
# spinner:0,\
# hl:yellow,\
# header:blue,\
# info:green,\
# pointer:red,\
# marker:red,\
# prompt:gray,\
# hl+:red"


FZF_COLORS="bg+:#363a4f,\
bg:#24273a,\
spinner:#f4dbd6,\
hl:#ed8796,\
fg:#cad3f5,\
header:#ed8796,\
info:#c6a0f6,\
pointer:#f4dbd6,\
marker:#f4dbd6,\
fg+:#cad3f5,\
prompt:#c6a0f6,\
hl+:#ed8796"

export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--color='$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"

export NEOVIDE_FRAME='none'

# starship.toml
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/zsh/startship.toml
# . "$HOME/.cargo/env"
