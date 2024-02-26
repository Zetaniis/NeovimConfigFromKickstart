return {

    -- THEMES

    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     -- priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         -- load the colorscheme here
    --         vim.cmd([[colorscheme tokyonight]])
    --     end,
    -- },

    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        -- priority = 1000,
        config = function()
            require('onedark').setup({
                style = 'darker'
            })
            vim.cmd.colorscheme 'onedark'

            -- vim.cmd([[
            --     hi Normal guibg='#000000'
            -- ]])
            --
            -- vim.cmd([[
            --     hi EndOfBuffer guibg='#000000'
            -- ]])
            --
            -- vim.cmd([[
            --     hi SignColumn guibg='#000000'
            -- ]])

            -- this, I think is a better way than the above
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#111111"} )
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        end,
    },


    -- {
    --     "rebelot/kanagawa.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     on_colors = function(colors)
    --         colors.bg = "#ffffff"
    --     end,
    --     config = function()
    --         vim.cmd([[colorscheme kanagawa]])
    --     end,
    -- },


    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require 'nordic' .load()
    --     end
    -- },
    --
    -- {
    --     "bluz71/vim-moonfly-colors",
    --     name = "moonfly",
    --     lazy = false,
    --     priority = 1000,
    -- },
    --
    -- {
    --     "mcchrish/zenbones.nvim",
    --     -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    --     -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    --     -- In Vim, compat mode is turned on as Lush only works in Neovim.
    --     dependencies = "rktjmp/lush.nvim",
    -- },

    -- for testing and editing themeing on the fly
    { 'rktjmp/lush.nvim' },

}
