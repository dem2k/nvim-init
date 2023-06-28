return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require("which-key").setup({
      require("which-key").register({
        ö = { name = "My Commands..." },
        s = { name = "Search..." },
        f = { name = "Find with Telescope..." },
        g = { name = "Git..." },
        l = { name = "Language server..." },
        --    t = { name = "Telescope..." },
      }, { prefix = "<leader>" })
    })
  end,
}
