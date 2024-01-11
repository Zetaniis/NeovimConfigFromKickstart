-- structure of the config:
-- lue/core - vanilla vim configs (settings, keybinds)
-- lua/plugins - plugins install and their configs
-- after/plugin - non lazy.nvim configs for plugins
-- check obsidian://open?vault=MainVault&file=General%20vim%20config for more info (private repo, for my eyes only)

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
-- TODO put the tested and confirmed plugins into their respective lua files in the lua folder
Plugins = {

    -- TODO figure what it it for and how to use it
    -- tpope/vim-sleuth

}

Opts = {

}

-- running the setup for the plugins
-- require("lazy").setup(Plugins, Opts)
-- require("lazy").setup("lua.core", Opts)
require("lazy").setup(
{
    {import = "plugins"},
    {Plugins},
}
, Opts)




