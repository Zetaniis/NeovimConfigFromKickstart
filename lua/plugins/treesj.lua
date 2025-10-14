return {

    -- splitting/joining blocks of code
    {
        'Wansmer/treesj',
        lazy = false,
        keys = { '<space>fb'},--, '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({--[[ your config ]]})
            vim.keymap.set({ 'n', 'v' }, '<leader>fb', ":TSJToggle<CR>", { desc = 'split/join code [b]lock' })
        end,
    },
}
