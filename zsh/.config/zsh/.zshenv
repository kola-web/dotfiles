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

# openAI
export OPENAI_API_KEY="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"
