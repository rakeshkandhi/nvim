return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mason-org/mason-lspconfig.nvim",
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
		local servers = {
			pyright = {},
			ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			yamlls = {},
			bashls = {},
			clangd = {},
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		for server, settings in pairs(servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
				settings = next(settings) and settings or nil,
			})
		end

		vim.lsp.enable(vim.tbl_keys(servers))

		-- =========================
		-- LSP Keymaps
		-- =========================
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)

		vim.keymap.set("n", "<A-Left>", "<C-o>", { desc = "Jump Back" })
		vim.keymap.set("n", "<A-Right>", "<C-i>", { desc = "Jump Forward" })
	end,
}
