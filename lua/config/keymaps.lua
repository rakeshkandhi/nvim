vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)


-- =========================
-- Convenience
-- =========================
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vim.cmd("echo ''")
end)