-- Based on kickstart.nvim
-- - Structure of the config:
-- - lua/core - vanilla vim configs (settings, keybinds)
-- - lua/plugins - plugins setup through lazynvim
-- - after/plugin - scripts, plugin configs sourced after lazynvim's setup

vim.g.mapleader = ' '
vim.g.localmapleader = ' '

require('core')


-- lazy.nvim package manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)



-- PLUGINS

-- The Plugins variable is used for testing new plugins
Plugins = {


}

Opts = {

}

-- I don't know if this is safe to defer the plugin manager, but as long as it doesn't break I can have a close to 0ms startup time
vim.defer_fn(function()
    require("lazy").setup(
        {
            { import = "plugins" },
            { Plugins },
        }
        , Opts)

end, 0)
