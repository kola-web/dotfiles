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

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# proxy
zsh_add_file "zsh-exports"
zsh_add_file "zsh-zimfw"
zsh_add_file "zsh-aliases"
zsh_add_file "kitty"
# zsh_add_file "zsh-prompt"


# +------------+
# | COMPLETION |
# +------------+

zsh_add_file "scripts/completion.zsh"

# pnpm
export PNPM_HOME="/Users/lijialin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
