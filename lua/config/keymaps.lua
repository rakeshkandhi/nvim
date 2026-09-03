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

-- =========================
-- Snippet Navigation (built-in vim.snippet, 0.10+)
-- =========================
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	end
	return "<Tab>"
end, { expr = true, desc = "Snippet Jump Next / Tab" })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if vim.snippet.active({ direction = -1 }) then
		return "<cmd>lua vim.snippet.jump(-1)<cr>"
	end
	return "<S-Tab>"
end, { expr = true, desc = "Snippet Jump Prev / S-Tab" })
