-- Defer used in order not to load the lazy plugin manager after this file
-- TODO I should probably split this file and move the contents to the repective lua folders
vim.defer_fn(function()
    -- [[ Configure Treesitter ]]
    -- gcc seems to break on windows, zig seems to work well
    -- require 'nvim-treesitter.install'.prefer_git = true;
    require 'nvim-treesitter.install'.compilers = { "zig" }



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

    -- Telescope stuff I barely understand
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
            -- TODO
            -- find a better way of making telescope fullscreen
            layout_config = { horizontal = { width = { padding = 0 }, height = {padding=0} }, vertical = { width = { padding = 0 }, height = {padding=0} } },

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
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
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
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })


    vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [g]it [f]iles' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' }) -- TODO figure this out
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[s]earch by [g]rep on git root' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[s]earch [r]esume' })
    vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[s]earch [k]ey maps' })


    -- See `:help nvim-treesitter`
    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
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



    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    --  if there is something compiling that is connected to treesitter it's probably beacuse of this function
    local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end


        nmap('<leader>rs', vim.lsp.buf.rename, '[r]ename [s]ymbol under cursor')
        -- TODO
        -- change the binding maybe
        nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
        nmap('gE', require('telescope.builtin').lsp_type_definitions, '[g]oto Type d[E]finition')
        nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[s]earch document [s]ymbols')
        nmap('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[s]earch workspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove folder')
        -- nmap('<leader>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[w]orkspace [l]ist folders')

        -- Create a command `:Format` local to the LSP buffer
        -- I have spc f as the format script, could probably delete this
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        -- this is from rust lsp config, not sure if I should run it or not
        -- require'completion'.on_attach(client)
    end


    -- add key chains and layers to which-key
    local wk = require('which-key')

    -- add layers
    wk.register {
        ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[d]ebug', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
        -- ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
        -- TODO figure out if need those workspaces
        ['<leader>p'] = { name = '[p]roject', _ = 'which_key_ignore' },
        ['<leader>v'] = { name = '[v]im', _ = 'which_key_ignore' },
        ['<leader>j'] = { name = '[j]ump', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[f]ormat', _ = 'which_key_ignore' },
        ['<leader>i'] = { name = '[i]nsert', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[t]oggle', _ = 'which_key_ignore' },
        ['<leader>e'] = { name = '[d]iagnostics', _ = 'which_key_ignore' },
    }

    -- add vanilla vim motions that aren't setup by which-key presets in preview
    -- also keybinds that are setup in keys variable in a plugin setup
    wk.register({
        ["<C-w>K"] = "Move current window up-most",
        ["<C-w>J"] = "Move current window down-most",
        ['<C-w>H'] = "Move current window left-most",
        ['<C-w>L'] = "Move current window right-most",
        ["<C-w>r"] = "Rotate windows downwards/rightwards",
        ['<C-w>R'] = "Rotate windows upwards/leftwards",
        ['<C-w>x'] = "Exchange current with next",
        ['g#'] = "Search term under cursor",
        ['g*'] = "Search term under cursor",
        ['<leader>fb'] = 'split/join code [b]lock',
    }, { preset = true }
    )


    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },

        ['rust_analyzer'] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        },

    }

    -- Setup neovim lua configuration
    require('neodev').setup()
    -- require('rustaceanvim').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
            }
        end,
    }

    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },                                       -- file paths
            { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
            -- { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
            { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
            { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
            { name = 'calc' },                                       -- source for math calculation
        },
    }


    -- [[ Harpoon config ]]
    -- this is useful for binding a few files (3-4) that you come back to in the span of few seconds/minutes
    -- TODO not sure if I want to use it - the global marks seem to be fulfilling this functionality already
    --
    -- local mark = require('harpoon.mark')
    -- local ui = require('harpoon.ui')
    --
    -- vim.keymap.set('n', '<leader>ha', mark.add_file)
    -- vim.keymap.set('n', '<leader>hl', ui.toggle_quick_menu)
    --
    -- vim.keymap.set('n', '<C-a>', function ()
    --     ui.nav_file(1)
    -- end)
    -- vim.keymap.set('n', '<C-a>', function ()
    --     ui.nav_file(1)
    -- end)
    -- vim.keymap.set('n', '<C-a>', function ()
    --     ui.nav_file(1)
    -- end)
    -- vim.keymap.set('n', '<C-a>', function ()
    --     ui.nav_file(1)
    -- end)

    -- <leader>w is <C-w>, no which-key preview for now
    vim.keymap.set("n", "<leader>w", "<C-w>", { desc = '[w]indow' })


    -- [[ Hop config ]]

    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    vim.keymap.set("n", "<leader>h", function()
        hop.hint_words({})
    end, { desc = '[h]op to word' })

    vim.keymap.set("n", "<leader>jw", function()
        hop.hint_words({})
    end, { desc = '[h]op to word' })

    vim.keymap.set("n", "<leader>jj", function()
        hop.hint_char1({})
    end, { desc = '[j]ump to char' }) -- don't need that as I override the the fFtT keys with this one

    vim.keymap.set("n", "<leader>jJ", function()
        hop.hint_char2({})
    end, { desc = '[j]ump to 2chars' })

    vim.keymap.set("n", "<leader>jl", function()
        hop.hint_lines({})
    end, { desc = '[j]ump to [l]ine' })

    vim.keymap.set("n", "<leader>ju", function()
        hop.hint_patterns({}, "https*://")
    end, { desc = '[j]ump to [u]rl' })

    vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, })
    end, { remap = true })

    vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, })
    end, { remap = true })

    vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
    end, { remap = true })

    vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
    end, { remap = true })

    -- [[Debug layers]]

    vim.keymap.set("n", "<leader>dd", "TODO", { desc = 'start [d]ebug (TODO)' })
    vim.keymap.set("n", "<leader>dS", "TODO", { desc = '[S]top [d]ebug (TODO)' })
    vim.keymap.set("n", "<leader>dc", "TODO", { desc = '[c]ontinue [d]ebug (TODO)' })
    vim.keymap.set("n", "<leader>dp", "TODO", { desc = '[p]ause [d]ebug (TODO)' })
    vim.keymap.set("n", "<leader>dR", "TODO", { desc = '[R]estart [d]ebug (TODO)' })
    -- TODO transient:
    -- step into
    -- step over
    -- step out
    vim.keymap.set("n", "<leader>db", "TODO", { desc = 'toggle [b]reakpoint (TODO)' })
    vim.keymap.set("n", "<leader>dB", "TODO", { desc = 'toggle inline [B]reakpoint (TODO)' })
    vim.keymap.set("n", "<leader>dj", "TODO", { desc = '[j]ump to cursor (TODO)' })
    vim.keymap.set("n", "<leader>dv", "TODO", { desc = 'REPL (TODO)' })
    vim.keymap.set("n", "<leader>dw", "TODO", { desc = 'focus on [w]atch window (TODO)' })
    vim.keymap.set("n", "<leader>dW", "TODO", { desc = 'add to [W]atch (TODO)' })


    -- [[Fugitive config]]

    vim.keymap.set("n", "<leader>gg", ":G<CR>", { desc = 'open [g]it tool' })


    -- [[format layer]]

    vim.keymap.set("n", "<leader>fi", "TODO", { desc = 'change [i]ndentation (TODO)' })
    vim.keymap.set("n", "<leader>fd", "TODO", { desc = 'detect [i]ndentation (TODO)' })
    vim.keymap.set({ "n", "v" }, "<leader>fr", "TODO", { desc = '[r]eindent (TODO)' })
    vim.keymap.set("n", "<leader>ft", "TODO", { desc = 'convert indentation to [t]abs (TODO)' })
    vim.keymap.set("n", "<leader>fs", "TODO", { desc = 'convert indentation to [s]paces (TODO)' })
    vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = '[f]ormat using LSP' })

    -- [[insert layer]]

    vim.keymap.set("n", "<leader>is", "TODO", { desc = '[i]nsert [s]nippet (TODO)' })


    -- [[toggle layer]]

    vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = '[t]oggle [w]ord wrap' })
    vim.keymap.set("n", "<leader>tW", "TODO", { desc = '[t]oggle ignore trim [w]hitespace in diff (TODO)' })
    vim.keymap.set("n", "<leader>tc", "TODO", { desc = '[t]oggle find [c]ase insensitive (TODO)' })
    -- <c-w> o is good enough
    -- vim.keymap.set("n", "<leader>tz", "TODO", { desc = '[t]oggle [z]en mode (TODO)' })
    vim.keymap.set("n", "<leader>tt", "TODO", { desc = '[t]oggle [t]heme (TODO)' })
    vim.keymap.set('n', "<leader>tu", function()
        vim.cmd.UndotreeToggle()
        vim.cmd.UndotreeFocus()
    end, { desc = 'toggle [u]ndo tree' })
    vim.keymap.set("n", "<leader>tf", "TODO", { desc = '[t]oggle [f]ile tree (TODO)' })

    -- [[diagnostics layer]]
    vim.keymap.set("n", "<leader>e.", "TODO", { desc = '[e] diagnostic transient (TODO)' })
    vim.keymap.set("n", "<leader>tf", "TODO", { desc = '[t]oggle [f]ile tree (TODO)' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = 'Go to [p]revious diagnostic message' })
    vim.keymap.set('n', '<leader>eN', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = 'Go to [n]ext diagnostic message' })
    vim.keymap.set('n', '<leader>es', vim.diagnostic.open_float, { desc = '[s]how floating diagnostic message' })
    vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'open diagnostics [l]ist' })
    -- TODO organize imports
    -- vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
    --
    -- TODO
    -- rename file with LSP or something in order to preserve the references
end, 50)
