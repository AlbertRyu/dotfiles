-- CSV 编辑体验：不折行 + 高亮当前行，配合 csvview.nvim 的虚拟对齐
vim.opt_local.wrap = false
vim.opt_local.cursorline = true

local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
end

-- 对齐视图开关（虚拟文本，不改文件内容）
map("<leader>vv", "<cmd>CsvViewToggle<cr>", "CSV: 切换对齐视图")
-- 真正往文件里塞空格对齐 / 还原
map("<leader>va", "<cmd>RainbowAlign<cr>", "CSV: 写入式对齐")
map("<leader>vs", "<cmd>RainbowShrink<cr>", "CSV: 还原对齐")
-- 检查列数是否一致、引号是否闭合
map("<leader>vl", "<cmd>RainbowLint<cr>", "CSV: 检查格式")
-- 以光标处字符为分隔符重新着色
map("<leader>vd", "<cmd>RainbowDelim<cr>", "CSV: 设为分隔符")
-- RBQL 查询编辑器：SELECT a1, a3 WHERE a2 > 100
map("<leader>vq", "<cmd>RbSelect<cr>", "CSV: RBQL 查询")
