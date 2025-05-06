local M = {}

M.setup = function(config)
  config.ssh_domains = {}

  config.wsl_domains = {
    -- {
    --   name = "WSL:Ubuntu-24.04",
    --   distribution = "Ubuntu-24.04",
    --   username = "kola-wsl",
    --   default_cwd = "/home/kola-wsl",
    --   default_prog = {},
    -- },
  }
end

return M
