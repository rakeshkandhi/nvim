return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 100,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "  <author> · <abbrev_sha>",
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Hunk Navigation
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")

				-- Hunk Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
				map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
				map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>hi", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>hd", gs.diffthis, "Diff This")

				-- Toggle
				map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Line Blame")

				-- Copy commit hash from blame on current line
				map("n", "<leader>hy", function()
					local line = vim.fn.line(".")
					local file = vim.fn.expand("%:p")
					local result = vim.fn.system(
						string.format("git blame -L %d,%d --porcelain %s", line, line, file)
					)
					local hash = result:match("^(%x+)")
					if hash and #hash >= 8 then
						vim.fn.setreg("+", hash)
						vim.notify("[Git] Copied: " .. hash:sub(1, 8), vim.log.levels.INFO)
					else
						vim.notify("[Git] Could not get blame hash", vim.log.levels.WARN)
					end
				end, "Copy Blame Hash")
			end,
		})
	end,
}
