return {
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                color = { gui = '' },
                -- theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
