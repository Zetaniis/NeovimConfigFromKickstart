return {

    -- LSP plugings
    -- alternative plugin for LSP - LSP zero - supposedly easier to run with good defaults
    {
        -- configs
        'neovim/nvim-lspconfig',
        dependencies = {
            -- External tooling manager: LSPs, DAPs, linters, formatters
            'williamboman/mason.nvim',
            -- Connector for mason.nvim and nvim-lspconfig
            'williamboman/mason-lspconfig.nvim',

            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            -- for some reason the legacy release was recommended (in kickstart.lue)
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- LSP based completion, docs, help
            { "folke/neodev.nvim", opts = {} },

            'nvim-telescope/telescope.nvim',
        },
        config = function()
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
                -- below one uses raw nvim list, looks meh
                -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
                nmap('gI', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
                nmap('gE', require('telescope.builtin').lsp_type_definitions, '[g]oto Type d[E]finition')
                nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[s]earch document [s]ymbols')
                nmap('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    '[s]earch workspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', function() vim.lsp.buf.hover { border = "solid" } end,
                    'Hover Documentation')
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

                -- making esc work for hover buffer
                vim.keymap.set("n", "<Esc>", function()
                    -- Get the current window ID
                    local base_win_id = vim.api.nvim_get_current_win()
                    -- Iterate through all windows in the current tab page
                    for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        -- Check if the window is a floating window created by LSP hover
                        if win_id ~= base_win_id then
                            local win_cfg = vim.api.nvim_win_get_config(win_id)
                            if win_cfg.relative == "win" and win_cfg.win == base_win_id then
                                -- Close the hover window
                                vim.api.nvim_win_close(win_id, {})
                                return
                            end
                        end
                    end
                end, { buffer = bufnr, desc = "Close hover window" })
            end

            -- class Solution:
            --     def twoSum(self, nums: List[int], target: int) -> List[int]:
            --        require('mason')

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
                -- gopls = {},
                ts_ls = { filetypes = { 'ts', 'js' } },
                -- typescript_language_server = {},
                -- html = { filetypes = { 'html', 'twig', 'hbs'} },
                ['bashls'] = { filetypes = { 'bash', 'sh', 'cmd' }, shell = 'sh' },

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

                basedpyright = {},
                -- settings = {
                --     python = {
                --         analysis = {
                --             diagnosticMode = "workspace", -- Analyze the entire workspace
                --         },
                --     },
                -- },


                clangd = {},

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
                    -- TODO update this
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
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(4),
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                    -- ['<CR>'] = cmp.mapping.confirm {
                    --     behavior = cmp.ConfirmBehavior.Replace,
                    --     select = true,
                    -- },
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['Esc'] = cmp.mapping.abort(),
                    -- ['<Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_locally_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),
                    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     elseif luasnip.locally_jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),

                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },                                       -- file paths
                    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
                    { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
                    { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                    { name = 'calc' },                                       -- source for math calculation
                    { name = 'cmdline' }                                     -- command-line commands
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                window = {
                    -- documentation = cmp.config.window.bordered({
                    --     side_padding = 1,
                    --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel",
                    -- }),
                    documentation = {
                        max_width = 0,
                        max_height = 0,
                        border = nil,
                        winhighlight = "Normal:NormalFloat",
                    }
                },
            }
        end
    },
}
