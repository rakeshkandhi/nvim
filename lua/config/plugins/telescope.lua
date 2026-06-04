return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
		{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
		{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to References" },
		{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementations" },
		{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Go to Type Definition" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.95, -- 95% of screen width
					height = 0.95, -- 95% of screen height
					preview_width = 0.70, -- preview gets 70% of width
				},
				file_ignore_patterns = {
					"node_modules",
					"^.git/",
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
				},
			},
		})
	end,
}
