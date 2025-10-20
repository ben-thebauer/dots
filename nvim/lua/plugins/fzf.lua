return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        opts = {
        },
        keys = {
            { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
            { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
            { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
            { "<leader>ff", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git Root Dir)" },
            { "<leader>fF", "<cmd>FzfLua files<cr>", desc = "Find Files (cwd)" },
            -- { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
            { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
            { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
            { "<leader>sg", function() require('fzf-lua').live_grep({ cmd = "git -C $(git rev-parse --show-toplevel) grep --line-number --column --color=always" }) end, desc = "Grep (git Root Dir)" },
            { "<leader>sG", "<cmd>FzfLua live_grep<cr>", desc = "Grep (cwd)" },
            { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
            { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
            { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        },
    }
}
