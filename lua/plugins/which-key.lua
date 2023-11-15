return {
  "folke/which-key.nvim",
  opts = {},
  config = function()
    require("which-key").setup({
      require("which-key").register({
        ö = { name = "My Commands..." },
        s = { name = "Search..." },
        f = { name = "Telescope..." },
        g = { name = "Git..." },
        l = { name = "Language server..." },
        t = { name = "Terminal..." },
      }, { prefix = "<leader>" })
    })
  end,
}
