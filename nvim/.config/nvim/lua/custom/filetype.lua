vim.filetype.add {
  -- 扩展名
  extension = {
    pn = "potion",
    wxml = "html",
    wxss = "css",
    wxs = "javascript"
  },
  -- 文件名
  filename = {
    hosts = "sh",
    zpreztorc = "sh",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    [".*git/config"] = "gitconfig", -- Included in the plugin
    ["nginx/*.conf"] = "nginx", -- Included in the plugin
    ["nginx/template/*"] = "nginx", -- Included in the plugin
  },
}
