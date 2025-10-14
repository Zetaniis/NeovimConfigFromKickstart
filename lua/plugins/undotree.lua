return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', "<leader>tu", function()
                vim.cmd.UndotreeToggle()
                vim.cmd.UndotreeFocus()
            end, { desc = 'toggle [u]ndo tree' })
        end
    },
}
