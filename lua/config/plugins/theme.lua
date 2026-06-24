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
				gitsigns = true,
				cmp = true,
				notify = true,
				which_key = true,
				dashboard = true,
				indent_blankline = { enabled = true },
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
