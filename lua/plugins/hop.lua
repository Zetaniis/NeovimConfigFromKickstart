return {
    'smoka7/hop.nvim',
    version = "2.*.*",
    opts = function()
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection

        vim.keymap.set({"n",'v'}, "<leader>h", function()
            ---@diagnostic disable-next-line: missing-fields
            hop.hint_words({})
        end, { desc = '[h]op to word' })

        vim.keymap.set({"n",'v'}, "<leader>jw", function()
            ---@diagnostic disable-next-line: missing-fields
            hop.hint_words({})
        end, { desc = '[j]ump to [w]ord' })

        vim.keymap.set({"n",'v'}, "<leader>jj", function()
            ---@diagnostic disable-next-line: missing-fields
            hop.hint_char1({})
        end, { desc = '[j]ump to char' })     -- don't need that as I override the the fFtT keys with this one

        vim.keymap.set({"n",'v'}, "<leader>jJ", function()
            ---@diagnostic disable-next-line: missing-fields
            hop.hint_char2({})
        end, { desc = '[j]ump to 2chars' })

        vim.keymap.set({"n",'v'}, "<leader>jl", function()
            ---@diagnostic disable-next-line: missing-fields
            hop.hint_lines({})
        end, { desc = '[j]ump to [l]ine' })

        vim.keymap.set({"n", 'v'}, "<leader>ju", function()
            ---@diagnostic disable-next-line: missing-fields
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
    end,

}
