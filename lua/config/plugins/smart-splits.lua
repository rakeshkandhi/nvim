local ss = require("smart-splits")

ss.setup({
	mux = {
		backend = "smart-splits-backend-rex",
		-- Plain Alacritty has no REX_SESSION, so the Rex backend stays inactive.
		-- Inside Rex, detect() still turns it on. Don't warn about the other case.
		warn_if_unusable = false,
	},
})

-- ====================================================================
-- Directional navigation (seamlessly cross between splits & Rex panes)
-- ====================================================================
vim.keymap.set("n", "<C-h>", ss.move_cursor_left, { desc = "Move to Left Split / Rex Pane" })
vim.keymap.set("n", "<C-j>", ss.move_cursor_down, { desc = "Move to Below Split / Rex Pane" })
vim.keymap.set("n", "<C-k>", ss.move_cursor_up, { desc = "Move to Above Split / Rex Pane" })
vim.keymap.set("n", "<C-l>", ss.move_cursor_right, { desc = "Move to Right Split / Rex Pane" })

-- ====================================================================
-- Split / pane resizing
-- ====================================================================
vim.keymap.set("n", "<A-h>", ss.resize_left, { desc = "Resize Left Split / Rex Pane" })
vim.keymap.set("n", "<A-j>", ss.resize_down, { desc = "Resize Down Split / Rex Pane" })
vim.keymap.set("n", "<A-k>", ss.resize_up, { desc = "Resize Up Split / Rex Pane" })
vim.keymap.set("n", "<A-l>", ss.resize_right, { desc = "Resize Right Split / Rex Pane" })
