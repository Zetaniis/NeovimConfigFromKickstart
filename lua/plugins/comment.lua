return {

    {
        -- Commenting with gc
        'numToStr/Comment.nvim',
        opts = function()
            vim.keymap.set({'n', 'v', 'i'}, '<C-_>', require('Comment.api').toggle.linewise.current, { silent = true, desc = 'Toggle comment (Ctrl+/)' })
        end,
        lazy = false,
    },
}
