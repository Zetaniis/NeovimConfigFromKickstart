return {

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        -- cmd = "Telescope",
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        opts = function()
            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                    layout_config = { horizontal = { width = { padding = 0 }, height = { padding = 0 } }, vertical = { width = { padding = 0 }, height = { padding = 0 } } },

                },
            }


            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')

            -- Telescope live_grep in git root
            -- Function to find the git root directory based on the current buffer's path
            local function find_git_root()
                -- Use the current buffer's path as the starting point for the git search
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir
                local cwd = vim.fn.getcwd()
                -- If the buffer is not associated with a file, return nil
                if current_file == "" then
                    current_dir = cwd
                else
                    -- Extract the directory from the current file's path
                    current_dir = vim.fn.fnamemodify(current_file, ":h")
                end

                -- Find the Git root directory from the current file's path
                local git_root = vim.fn.systemlist("git -C " ..
                    vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
                    [1]
                if vim.v.shell_error ~= 0 then
                    print("Not a git repository. Searching on current working directory")
                    return cwd
                end
                return git_root
            end



            -- Custom live_grep function to search in git root
            -- TODO I wonder if you could add an signal/icon showing the end of the search
            -- this current implementation the prompt doesn't give any indication whether it's grepping or already stopped the search (with zero entries)
            local function live_grep_git_root()
                local git_root = find_git_root()
                if git_root then
                    require('telescope.builtin').live_grep({
                        search_dirs = { git_root },
                    })
                end
            end

            vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})



            -- See `:help telescope.builtin`
            vim.keymap.set({'n','v'}, '<leader>?', require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' })
            vim.keymap.set({'n','v'}, '<leader><space>', require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' })
            vim.keymap.set({'n','v'}, '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })


            vim.keymap.set({'n','v'}, '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [g]it [f]iles' })
            vim.keymap.set({'n','v'}, '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
            vim.keymap.set({'n','v'}, '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
            vim.keymap.set({'n','v'}, '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
            vim.keymap.set({'n','v'}, '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
            vim.keymap.set({'n','v'}, '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[s]earch by [g]rep on git root' })
            vim.keymap.set({'n','v'}, '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
            vim.keymap.set({'n','v'}, '<leader>sr', require('telescope.builtin').resume, { desc = '[s]earch [r]esume' })
            vim.keymap.set({'n','v'}, '<leader>sk', require('telescope.builtin').keymaps, { desc = '[s]earch [k]ey maps' })

            vim.keymap.set({"n",'v'}, "<leader>tt", ":Telescope colorscheme<CR>", { desc = '[t]oggle [t]heme' }) -- use nvchad theme picker when it gets into 3.0

            vim.keymap.set({'n','v'}, '<leader>el', require('telescope.builtin').diagnostics, { desc = 'open diagnostics [l]ist' })
        end

    },
}
