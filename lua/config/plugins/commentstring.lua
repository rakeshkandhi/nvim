return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		-- Skip the built-in autocmd integration (we hook manually below)
		vim.g.skip_ts_context_commentstring_module = true

		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		-- Override Neovim's built-in commentstring lookup to use treesitter context
		local get_option = vim.filetype.get_option
		vim.filetype.get_option = function(filetype, option)
			return option == "commentstring"
				and require("ts_context_commentstring.internal").calculate_commentstring()
				or get_option(filetype, option)
		end
	end,
}
