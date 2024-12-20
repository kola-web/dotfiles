set -gx TERM xterm-256color

source ~/.config/fish/env.fish
source ~/.config/fish/function.fish
source ~/.config/fish/exports.fish
source ~/.config/fish/alias.fish
source ~/.config/fish/before.init.fish

zoxide init fish | source
starship init fish | source

# fish_vi_key_bindings
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

fzf_configure_bindings --directory=\cf --variables=\e\cv
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
