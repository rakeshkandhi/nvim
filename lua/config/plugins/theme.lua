return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",

			integrations = {
				mason = true,
				telescope = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
