-- Plugins are loaded eagerly by vim.pack (no lazy-loading), so each module
-- below just runs its setup()/keymaps immediately, in a sensible order:
-- theme first, then treesitter/lsp, then the rest.
require("config.plugins.theme")
require("config.plugins.treesitter")
require("config.plugins.lsp")
require("config.plugins.telescope")
require("config.plugins.gitsigns")
require("config.plugins.autopairs")
require("config.plugins.which-key")
require("config.plugins.lint")
require("config.plugins.undotree")
require("config.plugins.tmux-navigator")
