-- Native formatting (replaces conform.nvim): run a filetype's formatter as
-- a shell filter over the buffer, falling back to the attached LSP server's
-- formatting if no shell formatter is configured for the filetype. Runs on
-- save, and manually via <A-S-f>.
local formatters = {
	lua = "stylua -",
	python = "ruff format -",
	javascript = "prettier --stdin-filepath %",
	javascriptreact = "prettier --stdin-filepath %",
	typescript = "prettier --stdin-filepath %",
	typescriptreact = "prettier --stdin-filepath %",
	json = "prettier --stdin-filepath %",
	jsonc = "prettier --stdin-filepath %",
	css = "prettier --stdin-filepath %",
	html = "prettier --stdin-filepath %",
	yaml = "prettier --stdin-filepath %",
	markdown = "prettier --stdin-filepath %",
}

local function format_buffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local cmd = formatters[ft]

	if cmd then
		-- Replace % with the actual buffer path for tools that need it
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local resolved = cmd:gsub("%%", bufname)

		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local input = table.concat(lines, "\n")

		local output = vim.fn.system(resolved, input)

		if vim.v.shell_error == 0 then
			local formatted = vim.split(output, "\n", { plain = true })
			-- Remove trailing empty line that shell commands often append
			if formatted[#formatted] == "" then
				table.remove(formatted)
			end
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
		end
	else
		-- No shell formatter configured: try the attached LSP server
		for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			if cl:supports_method("textDocument/formatting") then
				vim.lsp.buf.format({ bufnr = bufnr, async = false })
				break
			end
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format_buffer(args.buf)
	end,
})

vim.keymap.set("n", "<A-S-f>", function()
	format_buffer()
end, { desc = "Format Document" })
