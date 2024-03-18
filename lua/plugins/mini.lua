-- https://github.com/echasnovski/mini.nvim/
return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.ai").setup({})
        -- require("mini.map").setup({}) -- too slow on huge files...
        -- require("mini.animate").setup({})
        require("mini.tabline").setup({})
        require("mini.comment").setup({})
        require("mini.pairs").setup({})
        require("mini.surround").setup({
            mappings = {
                add = 'sa',            -- Add surrounding in Normal and Visual modes
                delete = 'sd',         -- Delete surrounding
                find = 'sf',           -- Find surrounding (to the right)
                find_left = 'sF',      -- Find surrounding (to the left)
                highlight = 'sh',      -- Highlight surrounding
                replace = 'sr',        -- Replace surrounding
                update_n_lines = 'sn', -- Update `n_lines`
                suffix_last = 'p',     -- Suffix to search with "prev" method
                suffix_next = 'n',     -- Suffix to search with "next" method
            },
            search_method = 'cover_or_next',
        })
        require('mini.indentscope').setup({ symbol = '┊', delay = 250, })

        require("mini.move").setup({
            mappings = {
                -- Move visual selection in Visual mode.
                left = "<M-Left>",
                right = "<M-Right>",
                up = "<M-Up>",
                down = "<M-Down>",
                -- Move current line in Normal mode
                line_left = "<M-Left>",
                line_right = "<M-Right>",
                line_up = "<M-Up>",
                line_down = "<M-Down>",
            },
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = false,
            },
        })
    end,
}
