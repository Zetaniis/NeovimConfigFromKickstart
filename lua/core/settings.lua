-- SETTINGS

-- Unified clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- Make line numbers default, with relative line distance to cursor
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable the use of mouse in vim
vim.o.mouse = 'a'


vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time, TODO not sure what values should I use 
vim.o.updatetime = 1000
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 100

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character


-- TODO figure out if there are any disadantages of running unix filetypes on windows
-- vim.o.fileformats = { 'unix', 'dos' }

-- TODO figure out if I want undotree to manage my backups
-- would also have to changet the getenv to something else for Windows
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true


vim.opt.incsearch = true


-- making some space on the end of the file
vim.opt.scrolloff = 5

-- TODO not sure what this is, research
-- vim.opt.isfname:append("@-@")


-- open help command in the right vertical window
vim.cmd([[:cabbrev h vert bo help ]])

-- h and l wrap on ends of the line
vim.cmd([[set whichwrap+=h,l]])
