return {
    {
        "catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
        opts = {
            neotree = true,
        },
	config = function()
	    vim.cmd([[colorscheme catppuccin-mocha]])
	end,
    },
}
