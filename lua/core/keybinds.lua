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

-- TODO after restructuring the config, make a leader command that will jump to the root of the config directory 
vim.keymap.set({'n', 'v'}, '<Leader>ve',  ":e $MYVIMRC<CR>", { desc = 'Edit VIM configuration file' })

vim.keymap.set({'n', 'v'}, '<Leader>pv', vim.cmd.Ex, { desc = 'Open vim file explorer' })
