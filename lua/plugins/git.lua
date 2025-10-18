return {


    -- wrapper for git commands with some additional commands
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set({"n",'v'}, "<leader>gg", ":vert G<CR>", { desc = 'open [g]it tool' })
        end
    },

    -- github integration
    -- {
    --     'tpope/vim-rhubarb',
    --     config = function()
    --         vim.keymap.set({"n", "v"}, "<leader>gu", ":GBrowse<CR>", { desc = 'open [g]it tool' })
    --     end
    -- }

}
