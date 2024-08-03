return {
    "nvim-pack/nvim-spectre",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        vim.keymap.set('n', '<leader>öss', '<cmd>lua require("spectre").toggle()<CR>', {
            desc = "Toggle Spectre"
        })
        vim.keymap.set('n', '<leader>ösw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
            desc = "Search current word"
        })
        vim.keymap.set('v', '<leader>ösw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "Search current word"
        })
        vim.keymap.set('n', '<leader>ösp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
            desc = "Search on current file"
        })
    end
}
