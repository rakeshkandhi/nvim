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

		-- =========================
		-- CSpell (spell check in code)
		-- =========================
		-- Shows misspellings as diagnostics; use <leader>ca to fix / add words.
		local cspell_config = vim.fn.stdpath("config") .. "/cspell.json"
		vim.lsp.config("cspell_ls", {
			capabilities = capabilities,
			cmd = { "cspell-lsp", "--stdio", "--config", cspell_config },
			filetypes = {
				"lua",
				"python",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"text",
				"gitcommit",
				"bash",
				"sh",
				"zsh",
				"c",
				"cpp",
				"rust",
				"go",
				"toml",
			},
		})

		local enabled = vim.tbl_keys(servers)
		table.insert(enabled, "cspell_ls")
		vim.lsp.enable(enabled)

		-- =========================
		-- LSP Keymaps
		-- =========================
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set({ "n", "v" }, "<leader>ca", function()
			local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
			local line_diags = vim.diagnostic.get(0, { lnum = lnum })
			local lsp_diags = {}
			for _, d in ipairs(line_diags) do
				local lsp_diag = {
					range = {
						start = { line = d.lnum, character = d.col },
						["end"] = { line = d.end_lnum or d.lnum, character = d.end_col or d.col },
					},
					severity = d.severity,
					message = d.message,
					source = d.source,
					code = d.code,
				}
				if d.user_data and d.user_data.lsp then
					lsp_diag.data = d.user_data.lsp.data
				end
				table.insert(lsp_diags, lsp_diag)
			end
			vim.lsp.buf.code_action({
				context = {
					diagnostics = lsp_diags,
				},
			})
		end, { desc = "Code Action" })

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
