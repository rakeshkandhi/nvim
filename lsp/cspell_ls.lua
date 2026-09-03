local cspell_lsp_path = vim.fn.exepath("cspell-lsp")
local cspell_config = vim.fn.stdpath("config") .. "/cspell.json"

return {
	-- cspell-lsp's npm package ships dist/bundle.mjs without a shebang, so its
	-- bin symlink isn't directly executable — invoke it via `node` explicitly.
	cmd = { "node", cspell_lsp_path, "--stdio", "--config", cspell_config },
	filetypes = {
		"lua", "python", "javascript", "javascriptreact", "typescript",
		"typescriptreact", "html", "css", "scss", "json", "jsonc", "yaml",
		"markdown", "text", "gitcommit", "bash", "sh", "zsh", "c", "cpp",
		"rust", "go", "toml",
	},
	root_markers = { ".git" },
}
