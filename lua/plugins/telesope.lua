-- https://github.com/nvim-telescope/telescope.nvim -- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    height = 0.85,
                    width = 0.95,
                    -- preview_cutoff = 120,  --default?
                    preview_width=0.65,
                },
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_cursor {
                        -- even more opts
                    },

                    -- pseudo code / specification for writing custom displays, like the one for "codeactions"
                    -- specific_opts = {
                    --   ["kind"] = {
                    --     make_indexed = function(items) -> indexed_items, width,
                    --     make_displayer = function(widths) -> displayer
                    --     make_display = function(displayer) -> function(e)
                    --     make_ordinal = function(e) -> string
                    --   },
                    --   -- for example to disable the custom builtin "codeactions" display do the following
                    --   codeactions = false,
                    -- }
                }
            }
        })

        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")

        -- See `:help telescope.builtin`
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = "Fuzzily search in current Buffer" })

        vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Existing Buffers" })
        vim.keymap.set("n", "<leader>fb", require("telescope.builtin").builtin, { desc = "Built-in Pickers" })
        vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recently opened Files" })
        vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Files" })
        vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "Current Word in Files" })
        vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })
        --vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Files" })
        vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits, { desc = "Commits" })
        vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches, { desc = "Branches" })
        vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "Status" })
        -- vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    end,
}
