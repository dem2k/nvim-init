if true then return {} end

-- https://github.com/numToStr/Comment.nvim
return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

