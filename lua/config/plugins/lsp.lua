-- =========================
-- Diagnostics Config (modern 0.12 format)
-- =========================
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "ⓘ",
			[vim.diagnostic.severity.HINT] = "⚑",
		},
	},
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
-- Enable LSP Servers (configs loaded from lsp/ directory)
-- =========================
-- Server configs live in ~/.config/nvim/lsp/<server>.lua (Neovim 0.11+).
-- Servers/tools themselves are installed by dev-env-setup's
-- scripts/install_deps.sh (install_lsp_tools), not Mason.
local servers = {
	"pyright", "ts_ls", "html", "cssls", "tailwindcss",
	"jsonls", "yamlls", "bashls", "clangd", "lua_ls",
}

local cspell_lsp_path = vim.fn.exepath("cspell-lsp")
if cspell_lsp_path ~= "" then
	table.insert(servers, "cspell_ls")
else
	vim.notify("cspell-lsp not found on PATH — spell-check diagnostics disabled", vim.log.levels.WARN)
end

vim.lsp.enable(servers)

-- =========================
-- LSP Keymaps
-- =========================
-- NOTE: Neovim 0.11+ provides these defaults out of the box:
--   grn  → vim.lsp.buf.rename()
--   gra  → vim.lsp.buf.code_action()
--   grr  → vim.lsp.buf.references()
--   gri  → vim.lsp.buf.implementation()
--   gO   → vim.lsp.buf.document_symbol()
--   C-S  → vim.lsp.buf.signature_help() (insert mode)
-- The keymaps below are kept as leader-key aliases and Telescope overrides.

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
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
end, { desc = "Prev Diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })

vim.keymap.set("n", "<A-Left>", "<C-o>", { desc = "Jump Back" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { desc = "Jump Forward" })

-- =========================
-- Inlay Hints (0.10+)
-- =========================
vim.keymap.set("n", "<leader>ti", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle Inlay Hints" })
