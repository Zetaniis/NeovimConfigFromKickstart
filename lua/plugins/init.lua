require 'nvim-treesitter.install'.compilers = {"zig"}

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
    {
    "nvim-treesitter/nvim-treesitter",
    opts = { 
        -- compilers = {'zig', 'gcc'},
    },
    -- install = {
    --     compilers = {"zig"},
    -- }
    -- compilers = { 'zig' }

  }, 
}
