return {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        opts = function()
            -- gcc seems to break on windows, zig seems to work well
            -- require 'nvim-treesitter.install'.prefer_git = true;
            require 'nvim-treesitter.install'.compilers = { "zig", "gcc" }
            -- See `:help nvim-treesitter`
            -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
            -- TODO: do something with this
            vim.defer_fn(function()
                require('nvim-treesitter.configs').setup {
                    -- Add languages to be installed here that you want installed for treesitter
                    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'toml', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'vimdoc' },

                    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
                    auto_install = false,

                    highlight = { enable = true },
                    indent = { enable = true },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            -- <c-space> doesn't work on Windows terminal, also <M-space> is reserved for a launcher
                            -- TODO change the keybinds
                            init_selection = '<c-space>',
                            node_incremental = '<c-space>',
                            scope_incremental = '<c-s>',
                            node_decremental = '<M-space>',
                        },
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                            keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ['aa'] = '@parameter.outer',
                                ['ia'] = '@parameter.inner',
                                ['af'] = '@function.outer',
                                ['if'] = '@function.inner',
                                ['ac'] = '@class.outer',
                                ['ic'] = '@class.inner',
                            },
                        },
                        move = {
                            enable = true,
                            set_jumps = true, -- whether to set jumps in the jumplist
                            goto_next_start = {
                                [']m'] = '@function.outer',
                                [']]'] = '@class.outer',
                            },
                            goto_next_end = {
                                [']M'] = '@function.outer',
                                [']['] = '@class.outer',
                            },
                            goto_previous_start = {
                                ['[m'] = '@function.outer',
                                ['[['] = '@class.outer',
                            },
                            goto_previous_end = {
                                ['[M'] = '@function.outer',
                                ['[]'] = '@class.outer',
                            },
                        },
                        swap = {
                            enable = true,
                            swap_next = {
                                ['<leader>fa'] = '@parameter.inner',
                            },
                            swap_previous = {
                                ['<leader>fA'] = '@parameter.inner',
                            },
                        },
                    },
                }
            end, 0)
        end
    },
    -- For debugging and creating/testing new features with treesitter
    -- { 'nvim-treesitter/playground' },

}
