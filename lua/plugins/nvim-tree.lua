return {
    { 'nvim-tree/nvim-tree.lua' },


    -- [[Nvim-tree confing]]
    -- vim.keymap.set("n", "<leader>tf", ":NvimTreeToggle<CR>", { desc = '[t]oggle [f]ile tree' })
    -- very laggy, discard for now
    -- vim.g.loaded_netrw       = 1
    -- vim.g.loaded_netrwPlugin = 1
    --
    -- local function my_on_attach(bufnr)
    --     local api = require "nvim-tree.api"
    --
    --     local function opts(desc)
    --         return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --     end
    --
    --     -- default mappings
    --     api.config.mappings.default_on_attach(bufnr)
    -- end
    -- require 'nvim-tree'.setup {
    --     on_attach = my_on_attach
    -- }
    --
    -- don't have it right now
    -- vim.keymap.set("n", "<leader>tf", ":NvimTreeToggle<CR>", { desc = '[t]oggle [f]ile tree' })
}
