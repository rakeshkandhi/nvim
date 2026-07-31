vim.keymap.set("n", "gl", vim.diagnostic.open_float)

vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vim.cmd("echo ''")
end)

-- =========================
-- VSCode-like Developer Keymaps
-- =========================

-- Move lines up and down (Alt+j/k in Normal, Insert, Visual modes)
-- Normal Mode
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
-- Insert Mode
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
-- Visual Mode
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- -- =========================
-- -- Built-in Spell Check Shortcuts
-- -- =========================
-- vim.keymap.set("n", "<leader>ss", "z=", { desc = "Spelling Suggestions (z=)" })
-- vim.keymap.set("n", "<leader>sa", "zg", { desc = "Add Word to Dict (zg)" })
-- vim.keymap.set("n", "<leader>st", "<cmd>set spell!<cr>", { desc = "Toggle Red Underline Spell Check" })
