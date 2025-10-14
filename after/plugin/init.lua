-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})




-- [[Debug layers]]
-- TODO check out how to get a debug plugin
vim.keymap.set("n", "<leader>dd", ":echo 'TODO'<CR>", { desc = 'start [d]ebug (TODO)' })
vim.keymap.set("n", "<leader>dS", ":echo 'TODO'<CR>", { desc = '[S]top [d]ebug (TODO)' })
vim.keymap.set("n", "<leader>dc", ":echo 'TODO'<CR>", { desc = '[c]ontinue [d]ebug (TODO)' })
vim.keymap.set("n", "<leader>dp", ":echo 'TODO'<CR>", { desc = '[p]ause [d]ebug (TODO)' })
vim.keymap.set("n", "<leader>dR", ":echo 'TODO'<CR>", { desc = '[R]estart [d]ebug (TODO)' })
-- TODO transient:
-- step into
-- step over
-- step out
-- could use which key hydra mode
vim.keymap.set("n", "<leader>db", ":echo 'TODO'<CR>", { desc = 'toggle [b]reakpoint (TODO)' })
vim.keymap.set("n", "<leader>dB", ":echo 'TODO'<CR>", { desc = 'toggle inline [B]reakpoint (TODO)' })
vim.keymap.set("n", "<leader>dj", ":echo 'TODO'<CR>", { desc = '[j]ump to cursor (TODO)' })
vim.keymap.set("n", "<leader>dv", ":echo 'TODO'<CR>", { desc = 'REPL (TODO)' })
vim.keymap.set("n", "<leader>dw", ":echo 'TODO'<CR>", { desc = 'focus on [w]atch window (TODO)' })
vim.keymap.set("n", "<leader>dW", ":echo 'TODO'<CR>", { desc = 'add to [W]atch (TODO)' })



-- [[insert layer]]
-- vim.keymap.set("n", "<leader>is", ":echo 'TODO'<CR>", { desc = '[i]nsert [s]nippet (TODO)' })


-- TODO organize imports
-- vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
