local function live_grep_filenames_only(opts)
	local make_entry = require("telescope.make_entry")
	opts = opts or {}
	local original_entry_maker = make_entry.gen_from_vimgrep(opts)

	opts.entry_maker = function(line)
		local entry = original_entry_maker(line)
		if entry then
			-- Access these to trigger the lazy parsing under the metatable
			local filename = entry.filename
			local path = entry.path

			-- Normalize paths to use forward slashes to prevent escaping issues on Windows
			if filename then
				entry.filename = filename:gsub("\\", "/")
			end
			if path then
				entry.path = path:gsub("\\", "/")
			end

			entry.display = function(display_entry)
				local display_filename = display_entry.filename:gsub("/", "\\")
				return string.format("%s:%s:%s", display_filename, display_entry.lnum, display_entry.col)
			end
		end
		return entry
	end

	require("telescope.builtin").live_grep(opts)
end

local telescope = require("telescope")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--no-ignore",
			"--glob", "!.git/",
			"--glob", "!node_modules/",
			"--glob", "!dist/",
			"--glob", "!build/",
			"--glob", "!.vscode/",
			"--glob", "!.venv/",
			"--glob", "!.vite/",
			"--glob", "!.next/",
			"--glob", "!out/",
			"--glob", "!coverage/",
			"--glob", "!.DS_Store",
			"--glob", "!package-lock.json",
			"--glob", "!.worktrees/",
			"--glob", "!.playwright-mcp/",
			"--glob", "!__pycache__/",
			"--glob", "!.pytest_cache/",
			"--glob", "!.mypy_cache/",
			"--glob", "!tsconfig.tsbuildinfo",
			"--glob", "!*.tsbuildinfo",
			"--glob", "!yarn.lock",
			"--glob", "!pnpm-lock.yaml",
			"--glob", "!poetry.lock",
		},
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.95,
			preview_width = 0.70,
			preview_cutoff = 0,
		},
		wrap_results = true,
		file_ignore_patterns = {
			"node_modules[\\/]",
			"%.git[\\/]",
			"%.DS_Store$",
			"dist[\\/]",
			"build[\\/]",
			"%.vscode[\\/]",
			"%.venv[\\/]",
			"%.vite[\\/]",
			"%.next[\\/]",
			"out[\\/]",
			"coverage[\\/]",
			"package%-lock%.json$",
			"%.worktrees[\\/]",
			"%.playwright%-mcp[\\/]",
			"__pycache__[\\/]",
			"%.pytest_cache[\\/]",
			"%.mypy_cache[\\/]",
			"tsconfig%.tsbuildinfo$",
			"%.tsbuildinfo$",
			"yarn%.lock$",
			"pnpm%-lock%.yaml$",
			"poetry%.lock$",
		},
	},

	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--color", "never",
				"--hidden",
				"--no-ignore",
				"--glob", "!.git/",
				"--glob", "!node_modules/",
				"--glob", "!dist/",
				"--glob", "!build/",
				"--glob", "!.vscode/",
				"--glob", "!.venv/",
				"--glob", "!.vite/",
				"--glob", "!.next/",
				"--glob", "!out/",
				"--glob", "!coverage/",
				"--glob", "!.DS_Store",
				"--glob", "!package-lock.json",
				"--glob", "!.worktrees/",
				"--glob", "!.playwright-mcp/",
				"--glob", "!__pycache__/",
				"--glob", "!.pytest_cache/",
				"--glob", "!.mypy_cache/",
				"--glob", "!tsconfig.tsbuildinfo",
				"--glob", "!*.tsbuildinfo",
				"--glob", "!yarn.lock",
				"--glob", "!pnpm-lock.yaml",
				"--glob", "!poetry.lock",
			},
			mappings = {
				i = {
					["<C-y>"] = function(prompt_bufnr)
						local action_state = require("telescope.actions.state")
						local actions = require("telescope.actions")
						local entry = action_state.get_selected_entry()
						if entry then
							local path = entry.value:gsub("\\", "/")
							vim.fn.setreg("+", path)
							vim.notify("Copied path: " .. path, vim.log.levels.INFO)
						end
						actions.select_default(prompt_bufnr)
					end,
				},
				n = {
					["y"] = function(prompt_bufnr)
						local action_state = require("telescope.actions.state")
						local actions = require("telescope.actions")
						local entry = action_state.get_selected_entry()
						if entry then
							local path = entry.value:gsub("\\", "/")
							vim.fn.setreg("+", path)
							vim.notify("Copied path: " .. path, vim.log.levels.INFO)
						end
						actions.select_default(prompt_bufnr)
					end,
				},
			},
		},
	},
})

-- fzf-native needs its one-time `make` build step (done by
-- scripts/setup_nvim.sh); don't let a fresh, not-yet-built clone crash config load.
local ok, err = pcall(telescope.load_extension, "fzf")
if not ok then
	vim.notify("telescope-fzf-native not built yet — run make in its pack dir\n" .. err, vim.log.levels.WARN)
end

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", live_grep_filenames_only, { desc = "Live Grep (Filenames Only)" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to Definition" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Go to References" })
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to Implementations" })
vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to Type Definition" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })
