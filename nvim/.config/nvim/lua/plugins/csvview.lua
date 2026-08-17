return {
	"hat0uma/csvview.nvim",
	ft = { "csv", "tsv" },
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	---@module "csvview"
	---@type CsvView.Options
	opts = {
		parser = {
			comments = { "#", "//" },
		},
		view = {
			display_mode = "border", -- 用竖线画列边界；想更轻可改成 "highlight"
			sticky_header = { enabled = true },
			min_column_width = 5,
			spacing = 2,
		},
		keymaps = {
			-- 字段 text object：cif 改一格，daf 连分隔符一起删
			textobject_field_inner = { "if", mode = { "o", "x" } },
			textobject_field_outer = { "af", mode = { "o", "x" } },
			-- 按字段左右跳，比 w/b 好使
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
			jump_next_row = { "<Enter>", mode = { "n", "v" } },
			jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
		},
	},
	config = function(_, opts)
		require("csvview").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "csv", "tsv" },
			group = vim.api.nvim_create_augroup("CsvViewAuto", { clear = true }),
			callback = function()
				require("csvview").enable()
			end,
		})
	end,
}
