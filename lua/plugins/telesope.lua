-- https://github.com/nvim-telescope/telescope.nvim -- Fuzzy Finder (files, lsp, etc)
return { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' },
      config = function ()
 require('telescope').setup ({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily search in current Buffer' })

vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Existing Buffers' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').builtin, { desc = 'Built-in Pickers' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Recently opened Files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Current Word in Files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live Grep' })
--vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Commits' })
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Branches' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Status' })
-- vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
-- vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
-- vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end,
}
