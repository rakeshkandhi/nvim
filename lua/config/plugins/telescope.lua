return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
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

		-- Telescope keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
		vim.keymap.set("n", "<leader>gc", builtin.git_commits)
		vim.keymap.set("n", "<leader>gb", builtin.git_branches)
		vim.keymap.set("n", "<leader>gs", builtin.git_status)

		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader>fk", builtin.keymaps)
		vim.keymap.set("n", "<leader>fc", builtin.commands)
		vim.keymap.set("n", "<leader>fw", builtin.grep_string)

		-- LSP Telescope keymaps
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
	end,
}
