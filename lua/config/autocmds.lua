-- =========================
-- Autocmds
-- =========================

-- Spellcheck
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },

	callback = function()
		vim.opt_local.spell = true
	end,
})

-- .env files → shell filetype
-- Matches .env, .env.local, .env.production, .env.development, etc.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "sh"
	end,
})
