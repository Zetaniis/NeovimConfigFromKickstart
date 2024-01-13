return {

    -- LSP plugings 
    -- alternative plugin for LSP - LSP zero - supposedly easier to run with good defaults
    {
        -- configs 
        'neovim/nvim-lspconfig',
        dependencies = {
            -- External tooling manager: LSPs, DAPs, linters, formatters
            'williamboman/mason.nvim',
            -- Connector for mason.nvim and nvim-lspconfig
            'williamboman/mason-lspconfig.nvim',

            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            -- for some reason the legacy release was recommended (in kickstart.lue)
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- LSP based completion, docs, help
            { "folke/neodev.nvim", opts = {} }
        },
    },
}
