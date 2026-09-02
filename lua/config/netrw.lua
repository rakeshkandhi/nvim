-- Native file explorer (built-in netrw, no plugin) — <leader>e opens a
-- tree-view browser IN the current window (like Telescope's find_files):
-- picking a file replaces it, no persistent sidebar left behind.
--
-- (g:netrw_browse_split, which controls <cr>'s target window, explicitly
-- does NOT apply to :Lexplore per `:h g:netrw_browse_split` — that's why
-- :Lexplore always leaves its sidebar open with files opened elsewhere.
-- Plain :Explore has no split at all, so browse_split's default of 0
-- ("re-use the same window") is exactly what we want here.)
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_banner = 0 -- hide the top banner
vim.g.netrw_browse_split = 0 -- <cr> reuses the current window
vim.g.netrw_altfile = 1 -- keep the alternate file correct

vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>", { silent = true, desc = "Open File Explorer" })

-- netrw's built-in `%` prompts for a filename but leaves the new buffer
-- unattached from the current window; explicitly edit it in place.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "%", function()
			local fname = vim.fn.input("Enter filename: ")
			if fname == "" then
				return
			end

			local dir = vim.b.netrw_curdir or vim.fn.getcwd()
			local path = dir .. "/" .. fname

			if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
				vim.notify("Already exists: " .. fname, vim.log.levels.WARN)
				return
			end

			if fname:match("/$") then
				vim.fn.mkdir(path, "p")
				vim.cmd("edit " .. vim.fn.fnameescape(dir))
			else
				local f = io.open(path, "w")
				if not f then
					vim.notify("Failed to create: " .. fname, vim.log.levels.ERROR)
					return
				end
				f:close()
				vim.cmd("edit " .. vim.fn.fnameescape(path))
			end
		end, { buffer = true, silent = true, noremap = true, desc = "Create file in place" })
	end,
})
