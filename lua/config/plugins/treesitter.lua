-- Parser install/update is handled by scripts/setup_nvim.sh (:TSUpdate),
-- not a build hook — vim.pack doesn't run those.
require("nvim-treesitter").setup({
	-- Auto-install parsers for filetypes you open
	auto_install = true,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},
})
