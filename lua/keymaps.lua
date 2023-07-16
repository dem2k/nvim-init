-- scroll window
vim.keymap.set("n", "<C-Up>", "<C-Y>", { desc = "Scroll window up" })
vim.keymap.set("n", "<C-Down>", "<C-E>", { desc = "Scroll window down" })

-- -- Move Lines (use mini.move.  https://github.com/echasnovski/mini.nvim/)
-- vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
-- vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
-- vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
-- vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })

-- ctrl-s to save file
vim.keymap.set("n", "<c-s>", "<cmd>w<cr>", { desc = "save buffer" })
vim.keymap.set("i", "<c-s>", "<esc><cmd>w<cr>a", { desc = "save buffer" })

-- vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>e", ":NeoTreeFloatToggle<cr>", { desc = "Open File Explorer" })
vim.keymap.set("n", "<leader>öw", ":set invwrap<cr>", { desc = "Toggle wrap lines" })
vim.keymap.set("n", "<leader>öu", ":w ++enc=utf8 %<cr>", { desc = "Save buffer as UTF-8" })
vim.keymap.set("n", "<leader>öl", ":w ++enc=iso-8859-15 %<cr>", { desc = "Save buffer as Latin1" })
vim.keymap.set("n", "<leader>öf", ":%!c:/scoop/apps/tidy/current/tidy.exe -xml -raw -indent -quiet -wrap 0<cr>", { desc = "Tidy XML" })

-- show unsichtbare zeichen?
vim.keymap.set("n", "<leader>öp", ":set invlist<cr>", { desc = "Toggle unseen Signs" })

-- x löscht nicht ins clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "x does not change clipboard" })

-- prev/next tab
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>",{desc="Previous Tab"})
vim.keymap.set("n", "<Tab>", ":bnext<cr>",{desc="Next Tab"})
vim.keymap.set("n", "<leader>b", ":b#<cr>",{desc="Last opened Buffer"})

-- vim.keymap.set("n", "<c-v>", "P")

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.opt.guifont = "Hack NF:h12"
    vim.keymap.set({ "i", "c" }, "<c-v>", "<c-r>+", { desc = "CTRL-V isn't map in Neovide" })
    vim.keymap.set("n", "<c-v>", "i<c-r>+<esc>l", { desc = "CTRL-V isn't map in Neovide" })
end

-- move in long lines
vim.keymap.set("n", "<Up>", "gk", { desc = "Move Cursor up in a long Line" })
vim.keymap.set("n", "<Down>", "gj", { desc = "Move Cursor down in a long Line" })

-- vv aktiviert Lineweise selektieren
vim.keymap.set("n", "vv", "V")

-- 
vim.keymap.set("n", "<leader>n", ":%s///gn<cr>",{desc="Count Search matches"})

