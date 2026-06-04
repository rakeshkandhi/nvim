return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	main = "nvim-treesitter",
	opts = {
		-- Auto-install parsers for filetypes you open
		auto_install = true,

		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},
	},
}
