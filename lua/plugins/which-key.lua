return {
    "folke/which-key.nvim",
    opts = {},
    config = function()
        require("which-key").setup({
            require("which-key").register({
                ["<leader>ö"] = { name = "My Commands..." },
                ["<leader>ös"] = { name = "Save Buffer..." },
                ["<leader>f"] = { name = "Telescope..." },
                ["<leader>g"] = { name = "Git..." },
                ["<leader>l"] = { name = "Language server..." },
                ["<leader>t"] = { name = "Terminal..." },
            })
        })
    end,
}
