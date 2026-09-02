if vim.fn.has("win32") == 1 then
	vim.g.undotree_DiffCommand = "C:\\Program Files\\Git\\usr\\bin\\diff.exe"
end

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle UndoTree" })
