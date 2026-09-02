vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true

vim.opt.updatetime = 300
vim.opt.showtabline = 0 -- no bufferline.nvim; hide the native tabline too

-- Global statusline (config.statusline draws it); tpipeline overrides this
-- to 0 inside tmux — see the note in config.pack.
vim.opt.laststatus = 3

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Trackpad / mouse wheel scrolling
vim.keymap.set("n", "<ScrollWheelDown>", "j", { silent = true })
vim.keymap.set("n", "<ScrollWheelUp>", "k", { silent = true })

vim.keymap.set("n", "<ScrollWheelLeft>", "h", { silent = true })
vim.keymap.set("n", "<ScrollWheelRight>", "l", { silent = true })
