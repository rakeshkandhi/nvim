-- Native statusline (replaces lualine.nvim) with modern aesthetic.

-- Catppuccin Mocha Palette
local colors = {
	base = "#1E1E2E",
	surface = "#313244",
	text = "#CDD6F4",
	pink = "#F5C2E7",
	blue = "#89B4FA",
}

-- Modern Highlight Groups
vim.api.nvim_set_hl(0, "StlMode", { fg = colors.base, bg = colors.pink, bold = true })
vim.api.nvim_set_hl(0, "StlModeSep", { fg = colors.pink, bg = colors.base })

vim.api.nvim_set_hl(0, "StlInfo", { fg = colors.text, bg = colors.surface })
vim.api.nvim_set_hl(0, "StlInfoSep", { fg = colors.surface, bg = colors.base })

vim.api.nvim_set_hl(0, "StlBranch", { fg = colors.base, bg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "StlBranchSep", { fg = colors.blue, bg = colors.base })

vim.api.nvim_set_hl(0, "StlPath", { fg = colors.text, bg = colors.base, bold = true })

local modes = {
	n = " NORMAL ",
	i = " INSERT ",
	v = " VISUAL ",
	V = " V-LINE ",
	["\22"] = " V-BLOCK ",
	c = " COMMAND ",
	t = " TERMINAL ",
	R = " REPLACE ",
	s = " SELECT ",
	S = " S-LINE ",
	["\19"] = " S-BLOCK ",
}

function _G._statusline()
	local m = vim.fn.mode()
	local mode_name = modes[m] or (" " .. m:upper() .. " ")

	local path = vim.b.rel_path or "%f"
	local branch_str = vim.b.git_branch and ("%#StlBranchSep#%#StlBranch# " .. vim.b.git_branch .. " %#StlBranchSep#%*") or ""

	local diag = ""
	local counts = vim.diagnostic.count(0) or {}
	local labels = { " ", " ", " ", " " }
	local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
	for i = 1, 4 do
		if counts[i] and counts[i] > 0 then
			diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. " %*"
		end
	end

	local mode_block = "%#StlModeSep#%#StlMode#" .. mode_name .. "%#StlModeSep#%*"

	local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
	local info_block = "%#StlInfoSep#%#StlInfo#" .. ft .. "  %l:%c %#StlInfoSep#%*"

	local path_block = "%#StlPath# " .. path .. " %*"

	return " " .. mode_block .. " %=" .. diag .. info_block .. path_block .. branch_str .. " "
end

-- Use vim.fs.root() (0.10+) and vim.system() (0.10+) instead of shelling
-- out to git — cleaner, faster, non-blocking capable.
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufpath = vim.api.nvim_buf_get_name(0)
		local root = vim.fs.root(0, ".git")
		if root then
			local obj = vim.system({ "git", "branch", "--show-current" }, { text = true, cwd = root }):wait()
			vim.b.git_branch = (obj.stdout or ""):gsub("%s+$", "")
			-- Compute path relative to project root
			if bufpath ~= "" then
				vim.b.rel_path = bufpath:sub(#root + 2)
			else
				vim.b.rel_path = "%f"
			end
		else
			vim.b.git_branch = nil
			vim.b.rel_path = vim.fn.expand("%:p:~")
		end
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd("redrawstatus!")
	end,
})

vim.o.statusline = "%!v:lua._statusline()"
