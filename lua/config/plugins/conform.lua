return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
			},
		})

		-- Auto format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
					quiet = true,
				})
			end,
		})

		-- Format keymap
		local format_fn = function()
			require("conform").format({
				async = true,
				lsp_fallback = true,
			})
		end
		vim.keymap.set("n", "<leader>f", format_fn, { desc = "Format Document" })
		vim.keymap.set("n", "<A-S-f>", format_fn, { desc = "Format Document (VSCode-like)" })
	end,
}
