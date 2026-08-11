return {
	"vimpostor/vim-tpipeline",
	lazy = false,
	init = function()
		if vim.env.TMUX then
			vim.opt.laststatus = 0
			vim.g.tpipeline_autoembed = 1
			vim.g.tpipeline_statusline = ""
		end
	end,
}
