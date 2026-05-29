-- =========================
-- Basic Settings
-- =========================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =========================
-- Bootstrap lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	-- LSP
	{ "neovim/nvim-lspconfig" },

	-- Mason
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"mason-org/mason-lspconfig.nvim",
	},

	-- Formatter
	{
		"stevearc/conform.nvim",
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
})

-- =========================
-- Mason
-- =========================
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"lua_ls",
		"ts_ls",
	},
})

-- =========================
-- LSP
-- =========================
vim.lsp.config("pyright", {})
vim.lsp.config("ts_ls", {})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable({
	"pyright",
	"ts_ls",
	"lua_ls",
})

-- =========================
-- Formatter
-- =========================
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

require("catppuccin").setup({
	flavour = "mocha",

	integrations = {
		mason = true,
		telescope = true,
		native_lsp = {
			enabled = true,
		},
	},
})

vim.cmd.colorscheme("catppuccin")

-- =========================
-- Telescope
-- =========================
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})

-- =========================
-- Formatting
-- =========================
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end)

vim.keymap.set("n", "<Esc>", function()
    vim.cmd("nohlsearch")
    vim.cmd("echo ''")
end)

-- =========================
-- Convenience
-- =========================
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- =========================
-- LSP Keymaps
-- =========================
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.keymap.set("n", "<A-Left>", "<C-o>", { desc = "Jump Back" })
vim.keymap.set("n", "<A-Right>", "<C-i>", { desc = "Jump Forward" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
