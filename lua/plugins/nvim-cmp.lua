return {

    {
        -- Autocompletion
        -- could be useful to check - https://youtu.be/NL8D8EkphUw?si=0HBrsuGqCz4yBsDR&t=756
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Not sure what kind of autocompletion should I use so I just pasted the ones from the kickstart.nvim
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
}
