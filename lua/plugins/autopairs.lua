if true then return {} end

-- https://github.com/windwp/nvim-autopairs
return {
  "windwp/nvim-autopairs",
  -- is opt = {} same as require..setup.. ?
  config = function()
    require("nvim-autopairs").setup({})
    -- add your code here
  end,
}
