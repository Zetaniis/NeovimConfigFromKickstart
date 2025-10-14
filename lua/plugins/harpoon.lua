return {
    {
        'theprimeagen/harpoon',
        opts = function()
            -- [[ Harpoon config ]]
            -- this is useful for binding a few files (3-4) that you come back to in the span of few seconds/minutes

            local mark = require('harpoon.mark')
            local ui = require('harpoon.ui')

            vim.keymap.set('n', '<leader>a', mark.add_file, { desc = "[a]dd buffer to harpoon" })
            vim.keymap.set('n', '<leader>sH', ui.toggle_quick_menu, { desc = "[s]earch [H]arpooned buffers" })
            vim.keymap.set('n', '<leader>l', ui.toggle_quick_menu, { desc = "[s]earch [H]arpooned buffers" })
            vim.keymap.set('n', '<leader>7', function()
                ui.nav_file(1)
            end, { desc = "1 Harpooned buffer" })
            vim.keymap.set('n', '<leader>8', function()
                ui.nav_file(2)
            end, { desc = "2 Harpooned buffer" })
            vim.keymap.set('n', '<leader>9', function()
                ui.nav_file(3)
            end, { desc = "3 Harpooned buffer" })
            vim.keymap.set('n', '<leader>0', function()
                ui.nav_file(4)
            end, { desc = "4 Harpooned buffer" })
            vim.keymap.set('n', '<leader>6', function()
                ui.nav_file(5)
            end, { desc = "5 Harpooned buffer" })
        end
    },
}
