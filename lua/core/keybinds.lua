-- KEYBINDS

-- I think this is to prevent the space from doing anything and just serve as a leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- opening base config file for neovim - init.lua - and changing working directory to the config one
vim.keymap.set({ 'n', 'v' }, '<Leader>vc', function()
        vim.cmd([[cd `=stdpath("config")`]])
        vim.cmd([[e init.lua]])
    end,
    { desc = 'Edit [v]IM [c]onfiguration' })


vim.keymap.set({ 'n', 'v' }, '<Leader>pv', vim.cmd.Ex, { desc = 'Open vim file explorer' })


-- moving line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line up [v] only' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line down [v] only' })

-- classic connecting lines,
vim.keymap.set("n", "J", "J")
-- connecting lines that makes the cursor stay
-- vim.keymap.set("n", "J", "mzJ`z")

-- making the cursor stay in the middle while moving half page
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")


-- making search terms stay in the middle
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- pasting over something without swaping the registers, check normal pasting over something for explanation
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = '[P]aste over and retain reg' })

-- more elegant fix for working with both vim registers and clipboard at the same time
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- TODO if I ever get to using a cli session manager (eg. tmux) it would be wise to have a keybind that lists all sessions and swap between them seamlessly

-- TODO research quickfix and quickfix navigation
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replacing the word that your cursor is on
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace under cursor' })
