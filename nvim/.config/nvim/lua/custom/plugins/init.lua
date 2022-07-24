-- custom/plugins/init.lua has to return a table
-- THe plugin name is github user or organization name/reponame

return {
  ["mg979/vim-visual-multi"] = {},
  ["kola-web/vim-indent-object"] = {},
  ["kana/vim-textobj-user"] = {},
  ["whatyouhide/vim-textobj-xmlattr"] = {},
  ["kana/vim-textobj-entire"] = {},
  ["wellle/targets.vim"] = {},
  ["tpope/vim-repeat"] = {},
  ["tpope/vim-surround"] = {},
  ["gbprod/substitute.nvim"] = {},

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "vue",
        "json",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
    },
  },
}
