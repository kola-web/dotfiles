local platform = require("utils.platform")()
local M = {}

M.setup = function(config)
  config.ssh_domains = {
    -- yazi's image preview on Windows will only work if launched via ssh from WSL
    {
      name = "wsl.ssh",
      remote_address = "localhost",
      multiplexing = "None",
      default_prog = { "fish", "-l" },
      assume_shell = "Posix",
    },
  }

  config.wsl_domains = {
    {
      name = "WSL:Ubuntu-24.04",
      distribution = "Ubuntu",
      username = "kola",
      default_cwd = "/home/kola",
      default_prog = {},
    },
  }
end

return M
