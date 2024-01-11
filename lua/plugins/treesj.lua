return {

    -- splitting/joining blocks of code
    {
        'Wansmer/treesj',
        keys = { '<space>m'},--, '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({--[[ your config ]]})
        end,
    },
}
