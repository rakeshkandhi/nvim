-- Native file explorer (built-in netrw, no plugin) — <leader>e toggles a
-- persistent tree-view sidebar on the left; picking a file opens it in
-- your main window (the sidebar stays open, like nvim-tree/neo-tree).
--
-- The mechanism: `:Lexplore` sends <cr>-selected files to whatever window
-- number is in g:netrw_chgwin (`:h netrw-editwindow`) — NOT g:netrw_browse_split,
-- which `:h g:netrw_browse_split` says explicitly does not apply to :Lexplore.
-- Per `:h netrw-:Lexplore`, netrw itself auto-sets an uninitialized chgwin
-- to window 2 the first time it opens (exactly right for one main window +
-- one sidebar) — no need to compute/track it ourselves.
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_banner = 0 -- hide the top banner
vim.g.netrw_winsize = 25 -- sidebar width (% of columns)
vim.g.netrw_altfile = 1 -- keep the alternate file correct

vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<cr>", { silent = true, desc = "Toggle File Explorer" })

-- netrw's built-in `%` (create file) opens the new buffer in the netrw
-- window itself instead of respecting netrw_chgwin. Override it to go to
-- the same main window that <cr>-selected files use.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		-- Double-click opens file/dir (default maps to `-` which goes up)
		vim.keymap.set("n", "<2-LeftMouse>", "<CR>", {
			buffer = true,
			remap = true,
			silent = true,
			desc = "Double-click opens file/dir",
		})

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
				-- New directory: just refresh the netrw listing in place.
				vim.fn.mkdir(path, "p")
				vim.cmd("edit")
			else
				local f = io.open(path, "w")
				if not f then
					vim.notify("Failed to create: " .. fname, vim.log.levels.ERROR)
					return
				end
				f:close()

				local escaped = vim.fn.fnameescape(path)
				local target_win = vim.g.netrw_chgwin
				if target_win and target_win > 0 and target_win <= vim.fn.winnr("$") then
					vim.cmd(target_win .. "wincmd w")
				end
				vim.cmd("edit " .. escaped)
			end
		end, { buffer = true, silent = true, noremap = true, desc = "Create file in main window" })
	end,
})
