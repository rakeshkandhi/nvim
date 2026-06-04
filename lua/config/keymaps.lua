vim.keymap.set("n", "gl", vim.diagnostic.open_float)


vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vim.cmd("echo ''")
end)

-- =========================
-- VSCode-like Developer Keymaps
-- =========================

-- Save file with Ctrl+S (Normal, Insert, Visual modes)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
	if vim.bo.modifiable and vim.bo.buftype == "" then
		vim.cmd("write")
	end
end, { desc = "Save File" })

-- Toggle comments with Ctrl+/ or Ctrl+_ (Normal, Visual modes)
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment" })

-- Indent/Outdent blocks with Tab/Shift+Tab (Visual mode)
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Outdent selection" })

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

