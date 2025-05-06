local platform = require("utils.platform")()
local M = {}

M.setup = function(config)
  if platform.is_win then
    config.default_prog = { "pwsh" }
    config.launch_menu = {
      { label = "PowerShell Core", args = { "pwsh" } },
      { label = "PowerShell Desktop", args = { "powershell" } },
      { label = "Command Prompt", args = { "cmd" } },
      {
        label = "Git Bash",
        args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
      },
    }
  elseif platform.is_mac then
    config.default_prog = { "/opt/homebrew/bin/zsh", "-l" }
    config.launch_menu = {
      { label = "Bash", args = { "bash", "-l" } },
      { label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
      { label = "Zsh", args = { "/opt/homebrew/bin/zsh", "-l" } },
    }
  elseif platform.is_linux then
    config.default_prog = { "fish", "-l" }
    config.launch_menu = {
      { label = "Bash", args = { "bash", "-l" } },
      { label = "Fish", args = { "fish", "-l" } },
      { label = "Zsh", args = { "zsh", "-l" } },
    }
  end
end

return M
