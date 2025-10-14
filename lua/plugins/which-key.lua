return {
    {
        "folke/which-key.nvim", -- lazy=true
        opts = function()
            -- add key chains and layers to which-key
            local wk = require('which-key')

            -- add layers
            wk.add({
                { "<leader>c",  group = "[c]ode" },
                { "<leader>c_", hidden = true },
                { "<leader>d",  group = "[d]ebug" },
                { "<leader>d_", hidden = true },
                { "<leader>e",  group = "[e] diagnostics" },
                { "<leader>e_", hidden = true },
                { "<leader>f",  group = "[f]ormat" },
                { "<leader>f_", hidden = true },
                { "<leader>g",  group = "[g]it" },
                { "<leader>g_", hidden = true },
                { "<leader>i",  group = "[i]nsert" },
                { "<leader>i_", hidden = true },
                { "<leader>j",  group = "[j]ump" },
                { "<leader>j_", hidden = true },
                { "<leader>p",  group = "[p]roject" },
                { "<leader>p_", hidden = true },
                { "<leader>r",  group = "[r]ename" },
                { "<leader>r_", hidden = true },
                { "<leader>s",  group = "[s]earch" },
                { "<leader>s_", hidden = true },
                { "<leader>t",  group = "[t]oggle/[t]ab" },
                { "<leader>t_", hidden = true },
                -- TODO figure out if need those workspaces
                -- { '<leader>w', group = '[w]orkspace'},
                -- { "<leader>w_", hidden = true },
                { "<leader>v",  group = "[v]im" },
                { "<leader>v_", hidden = true },
            })

            -- add vanilla vim motions that aren't setup by which-key presets in preview
            -- also keybinds that are setup in keys variable in a plugin setup
            wk.add({
                { "<C-w>H", desc = "Move current window left-most" },
                { "<C-w>J", desc = "Move current window down-most" },
                { "<C-w>K", desc = "Move current window up-most" },
                { "<C-w>L", desc = "Move current window right-most" },
                { "<C-w>R", desc = "Rotate windows upwards/leftwards" },
                { "<C-w>r", desc = "Rotate windows downwards/rightwards" },
                { "<C-w>x", desc = "Exchange current with next" },
                { "g#",     desc = "Search term under cursor" },
                { "g*",     desc = "Search term under cursor" },

            })
        end
    },
}
