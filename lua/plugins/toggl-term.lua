return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
    },
    config = function()
        require("toggleterm").setup({})
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit  = Terminal:new({
            cmd = "lazygit.exe",
            -- hidden = true,
            -- dir = "git_dir",
            direction = "tab",
            float_opts = {
                -- border = "single",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.keymap.set("n", "<leader>gg", "<cmd>:lua _lazygit_toggle()<cr>",
            { desc = "LazyGit", noremap = true, silent = true })
    end
}
