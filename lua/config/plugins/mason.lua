return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Python
					"pyright",
					-- JS / TS
					"ts_ls",
					-- Web
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",
					-- YAML
					"yamlls",
					-- Shell
					"bashls",
					-- C / C++
					"clangd",
					-- Lua
					"lua_ls",
				},
			})
		end,
	},
}
