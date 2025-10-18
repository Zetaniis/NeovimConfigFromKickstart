-- KEYBINDS

-- I think this is to prevent the space from doing anything and just serve as a leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- opening base config file for neovim - init.lua - and changing working directory to the config one
vim.keymap.set({ 'n' }, '<Leader>vc', function()
        vim.cmd([[cd `=stdpath("config")`]])
        vim.cmd([[e init.lua]])
    end,
    { desc = 'Edit [v]IM [c]onfiguration' })


-- this option makes the file explorer stay on the side, doesn't seem that great, 
-- TODO a specific file tree plugin would be optimal
-- vim.keymap.set({ 'n' }, '<Leader>ve', ':Lex<CR>', { desc = 'Open [v]im file [e]xplorer' })
vim.keymap.set({ 'n' }, '<Leader>ve', ':Ex<CR>', { desc = 'Open [v]im file [e]xplorer' })

-- TODO
-- figure out a language agnostic way of running project code
-- maybe have a project depenedant file that stores the commands specific to a project, similarly to vscode
vim.keymap.set({ 'n' }, '<Leader>pb', "TODO", { desc = '[b]uild [p]roject (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>pd', "TODO", { desc = '[d]ebug [p]roject (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>pt', "TODO", { desc = '[t]est [p]roject (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>pr', "TODO", { desc = '[r]un [p]roject (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>bb', "TODO", { desc = '[b]uild [b]uffer (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>bd', "TODO", { desc = '[d]ebug [b]uffer (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>bt', "TODO", { desc = '[t]est [b]uffer (TODO)' })
vim.keymap.set({ 'n' }, '<Leader>br', "TODO", { desc = '[r]un [b]uffer (TODO)' })


-- moving line - not using it for now, got used to dd and pp
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line up [v] only' })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line down [v] only' })

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


-- TODO research quickfix and quickfix navigation
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replacing the word that your cursor is on
vim.keymap.set("n", "<leader>rc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = '[r]eplace under [c]ursor' })


vim.keymap.set({ "n" }, "<C-w>u", "TODO", { desc = '[u]ndo last window change (TODO)' })


vim.keymap.set({ "n" }, "<leader>sn", ":nohlsearch<CR>", { desc = '[n]o [s]earch highlight' })

-- transient mode for indenting while in selection
-- https://github.com/ChrisTitusTech/neovim/blob/main/titus-kickstart/lua/keymaps.lua#LL50C1-L51C30
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")



-- paste from the yank register
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = '[p]aste from yank register' })


-- [[Window layer]]
-- <leader>w is nicer to input than C-w when using typical window commands
-- <leader>w is <C-w>, no which-key preview for now
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = '[w]indow' })


-- [[buffer layer]]
vim.keymap.set('n', '<leader>bd', ":bd<CR>", { desc = '[d]elete [b]uffer' })
vim.keymap.set('n', '<leader>q', ":bd<CR>", { desc = 'delete buffer' })

-- [[ tabs ]]
-- gt/gT for next/prev tab
for i = 1, 5 do
    vim.keymap.set('n', '<leader>' .. i, i .. "gt", { desc = 'tab ' .. i })
end
vim.keymap.set("n", "<Leader>tn", "<cmd> tabnew<CR>", { desc = "[n]ew tab" })
vim.keymap.set("n", "<Leader>td", "<cmd> tabclose<CR>", { desc = "[d]elete tab" })


vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = '[t]oggle [w]ord wrap' })
-- vim.keymap.set("n", "<leader>tW", ":echo 'TODO'<CR>", { desc = '[t]oggle ignore trim [w]hitespace in diff (TODO)' })
vim.keymap.set("n", "<leader>tc", ":echo 'TODO'<CR>", { desc = '[t]oggle find [c]ase insensitive (TODO)' })



-- [[format layer]]
-- vim.keymap.set("n", "<leader>fi", ":echo 'TODO'<CR>", { desc = 'change [i]ndentation (TODO)' })
-- vim.keymap.set("n", "<leader>fd", ":echo 'TODO'<CR>", { desc = 'detect [i]ndentation (TODO)' })
-- vim.keymap.set({ "n", "v" }, "<leader>fr", ":echo 'TODO'<CR>", { desc = '[r]eindent (TODO)' })
-- vim.keymap.set("n", "<leader>ft", ":echo 'TODO'<CR>", { desc = 'convert indentation to [t]abs (TODO)' })
-- vim.keymap.set("n", "<leader>fs", ":echo 'TODO'<CR>", { desc = 'convert indentation to [s]paces (TODO)' })
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = '[f]ormat using LSP' })
vim.keymap.set("n", "<leader>fu", ":update | e ++ff=dos | setlocal ff=unix | w<CR>", { desc = 'dos2[u]nix' })
vim.keymap.set("n", "<leader>fU", ":update | e ++ff=dos | w<CR>", { desc = '[U]nix2dos' })



-- [[diagnostics layer]]

vim.keymap.set("n", "<leader>e.", ":echo 'TODO'<CR>", { desc = '[e] diagnostic transient (TODO)' }) -- could use which key hydra mode
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>ep', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Go to [p]revious diagnostic message' })
vim.keymap.set('n', '<leader>eN', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>en', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Go to [n]ext diagnostic message' })
vim.keymap.set('n', '<leader>es', vim.diagnostic.open_float, { desc = '[s]how floating diagnostic message' })
vim.keymap.set('n', '<leader>eK', vim.diagnostic.open_float, { desc = '[s]how floating diagnostic message' })
vim.keymap.set('n', '<leader>ek', vim.diagnostic.open_float, { desc = '[s]how floating diagnostic message' })
-- using the telescope diagnostics list
-- vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'open diagnostics [l]ist' })
