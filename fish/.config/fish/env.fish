# XDG
set -x XDG_CONFIG_HOME "$HOME/.config"

# editor
set -x EDITOR "nvim"
set -x VISUAL "nvim"

# Man pages
set -x MANPAGER 'nvim +Man!'

# fzf
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

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

set -x FZF_COLORS "bg+:#363a4f,\
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

set -x FZF_DEFAULT_OPTS "--height 60% \
--border sharp \
--color='$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"

set -x FZF_ALT_C_OPTS "--preview 'tree -C {} | head -n 10'"

set -x NEOVIDE_FRAME 'none'

# openAI
set -x OPENAI_API_KEY "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"

export STARSHIP_CONFIG=$XDG_CONFIG_HOME/fish/startship.toml

set -x PNPM_HOME /Users/lijialin/Library/pnpm
