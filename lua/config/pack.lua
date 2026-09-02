-- =========================
-- Native package manager (vim.pack, Neovim 0.12+)
-- =========================
-- No lazy-loading (event/cmd/ft) and no build hooks here — plugins are
-- loaded eagerly, and one-off build steps (TSUpdate, fzf-native's `make`)
-- are run by scripts/setup_nvim.sh after clone/pull.

-- vim-tpipeline reads these globals from its own plugin/ script at load
-- time, so they must be set before vim.pack.add() below (this replaces
-- lazy.nvim's `init` hook, which ran pre-load for the same reason).
if vim.env.TMUX then
	vim.opt.laststatus = 0
	vim.g.tpipeline_autoembed = 1
	vim.g.tpipeline_statusline = ""
	vim.g.tpipeline_restore = 1
	vim.g.tpipeline_clear = 1
end

vim.pack.add({
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/vimpostor/vim-tpipeline",
	"https://github.com/mbbill/undotree",
})

require("config.plugins")
