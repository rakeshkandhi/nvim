return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- =========================
		-- Diagnostics Config
		-- =========================
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				source = "if_many",
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
			},
		})

		-- =========================
		-- LSP Capabilities
		-- =========================
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- =========================
		-- LSP Server Configuration
		-- =========================
		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.lsp.config("ltex", {
			capabilities = capabilities,
			settings = {
				ltex = {
					language = "en-US",
					enabled = {
						"markdown",
						"text",
						"gitcommit",
					},
				},
			},
		})

		vim.lsp.enable({
			"pyright",
			"ts_ls",
			"lua_ls",
			"ltex",
		})

		-- =========================
		-- LSP Keymaps (Non-Telescope)
		-- =========================
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
			desc = "Diagnostic List",
		})

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				border = "rounded",
			})
		end)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

		vim.keymap.set("n", "<A-Left>", "<C-o>", {
			desc = "Jump Back",
		})

		vim.keymap.set("n", "<A-Right>", "<C-i>", {
			desc = "Jump Forward",
		})
	end,
}
