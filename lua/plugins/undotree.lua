return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set({'n', 'v'}, "<leader>tu", function()
                vim.cmd.UndotreeToggle()
                vim.cmd.UndotreeFocus()
            end, { desc = 'toggle [u]ndo tree' })
        end
    },
}
