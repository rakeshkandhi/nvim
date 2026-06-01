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
	-- Linting
	{
		"mfussenegger/nvim-lint",
	},
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({})

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"mbbill/undotree",
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
	},

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

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
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
		"ltex",
	},
})

-- =========================
-- LSP Capabilities
-- =========================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- =========================
-- LSP
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

-- =========================
-- Linting
-- =========================
local lint = require("lint")

lint.linters_by_ft = {
	python = { "ruff" },

	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },

	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- =========================
-- Theme
-- =========================
require("catppuccin").setup({
	flavour = "mocha",

	integrations = {
		mason = true,
		telescope = true,
	},
})

vim.cmd.colorscheme("catppuccin")

-- =========================
-- Telescope
-- =========================
local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
			"dist/",
			"build/",
			".next/",
			"coverage/",
			"__pycache__/",
			"%.pyc",
			"%.pyo",
			".venv/",
			"venv/",
			".mypy_cache/",
			".pytest_cache/",
		},
	},

	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
})

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)

-- =========================
-- Completion
-- =========================
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),

		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}),

		["<C-e>"] = cmp.mapping.abort(),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- =========================
-- Diagnostics
-- =========================
vim.diagnostic.config({
	virtual_text = true,
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
-- Spellcheck
-- =========================
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },

	callback = function()
		vim.opt_local.spell = true
	end,
})

-- =========================
-- Convenience
-- =========================
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vim.cmd("echo ''")
end)

-- =========================
-- Formatting
-- =========================
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end)

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},
	signs = true,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
	},
})

-- =========================
-- LSP Keymaps
-- =========================
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definition" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Implementations" })
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Type Definitions" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {
	desc = "Document Symbols",
})

vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, {
	desc = "Workspace Symbols",
})

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
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leader>gs", builtin.git_status)

vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fk", builtin.keymaps)
vim.keymap.set("n", "<leader>fc", builtin.commands)
vim.keymap.set("n", "<leader>fw", builtin.grep_string)
