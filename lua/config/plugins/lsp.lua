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
-- Native completion (replaces nvim-cmp)
-- =========================
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

-- =========================
-- LSP Server Configuration
-- =========================
-- Servers/tools themselves are installed by dev-env-setup's
-- scripts/install_deps.sh (install_lsp_tools), not Mason.
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
		settings = next(settings) and settings or nil,
	})
end

-- =========================
-- CSpell (spell check in code)
-- =========================
-- Shows misspellings as diagnostics; use <leader>ca to fix / add words.
local cspell_config = vim.fn.stdpath("config") .. "/cspell.json"
-- cspell-lsp's npm package ships dist/bundle.mjs without a shebang, so its
-- bin symlink isn't directly executable — invoke it via `node` explicitly.
local cspell_lsp_path = vim.fn.exepath("cspell-lsp")
vim.lsp.config("cspell_ls", {
	cmd = { "node", cspell_lsp_path, "--stdio", "--config", cspell_config },
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
if cspell_lsp_path ~= "" then
	table.insert(enabled, "cspell_ls")
else
	vim.notify("cspell-lsp not found on PATH — spell-check diagnostics disabled", vim.log.levels.WARN)
end
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
