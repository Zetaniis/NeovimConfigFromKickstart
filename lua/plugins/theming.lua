return {

    -- THEMES
    -- TODO find a scheme for both whole vim and lualine
    -- TODO try changing the background to very dark and see which one I like
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
                style='darker'
            })
            vim.cmd.colorscheme 'onedark'
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
    --
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

    { 'rktjmp/lush.nvim' },

}
