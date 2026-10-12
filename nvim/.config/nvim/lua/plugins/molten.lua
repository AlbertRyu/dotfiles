local pat = "^\\s*# %%"

-- 光标所在 cell 的范围（不含 # %% 标记行本身）
local function cell_bounds()
	local above = vim.fn.search(pat, "bcnW")
	local start = (above == 0) and 1 or above + 1
	local below = vim.fn.search(pat, "nW")
	local finish = (below == 0) and vim.fn.line("$") or below - 1
	return start, finish
end

local function eval_cell()
	local start, finish = cell_bounds()
	if finish < start then
		vim.notify("空 cell", vim.log.levels.WARN)
		return false
	end
	vim.fn.MoltenEvaluateRange(start, finish)
	return true
end

-- 跳到上/下一个 # %% 标记。光标在 cell 体内时，"prev" 先跳到本 cell 的标记行
local function goto_cell(dir)
	-- 归到第 1 列，让匹配以「行」为粒度：否则光标停在标记行中间时，
	-- 反向搜索会重新匹配到当前行开头而原地不动
	vim.fn.cursor(vim.fn.line("."), 1)
	if vim.fn.search(pat, (dir == "next") and "W" or "bW") == 0 then
		vim.notify(dir == "next" and "已是最后一个 cell" or "已是第一个 cell", vim.log.levels.INFO)
		return false
	end
	vim.cmd("normal! zz")
	return true
end

local function eval_and_next()
	if eval_cell() then
		goto_cell("next")
	end
end

return {
	{
		"benlubas/molten-nvim",
		-- 用 snacks.nvim 当图片后端 (#299) 还没进任何 release（最新 v1.9.2），只能跟 main
		version = false,
		dependencies = { "folke/snacks.nvim" },
		build = ":UpdateRemotePlugins",
		lazy = false,
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "snacks.nvim"
			vim.g.molten_output_win_max_height = 30

			vim.g.molten_virt_text_output = true
			vim.g.molten_auto_open_output = false
		end,

		-- ]] / [[ 设成 buffer-local，避免盖掉其它文件类型里 Vim 原生的 section 跳转
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "python", "quarto", "markdown" },
				callback = function(ev)
					vim.keymap.set("n", "]]", function()
						goto_cell("next")
					end, { buffer = ev.buf, desc = "下一个 molten cell" })
					vim.keymap.set("n", "[[", function()
						goto_cell("prev")
					end, { buffer = ev.buf, desc = "上一个 molten cell" })
				end,
			})
		end,

		keys = {
			{ "<leader>x", eval_cell, desc = "Molten eval cell" },
			{ "<leader>X", eval_and_next, desc = "Molten eval cell 并跳到下一个" },
			{ "<leader>mi", ":MoltenInit<CR>", desc = "启动 kernel" },
			{ "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "运行当前行" },
			{ "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "重跑 cell" },
			{ "<leader>mo", ":MoltenShowOutput<CR>", desc = "查看输出" },
			{ "<leader>m", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "运行选区" },
			{ "<leader>rd", ":MoltenDelete<CR>", mode = "n", desc = "Delete Cell" },
		},
	},
}
