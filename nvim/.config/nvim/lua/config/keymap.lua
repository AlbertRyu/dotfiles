-- Clear highlight on search when hit <ESC> in normal mode
vim.keymap.set("n", "<ESC>", function()
	vim.cmd("nohlsearch")
	vim.fn.setreg("/", "")
end)

-- For calling Lazygit
vim.keymap.set("n", "<leader>gg", function()
	vim.cmd("terminal Lazygit")
	vim.cmd("startinsert")
end)

-- Set <J>-<K> to be the shortcut of Esc, very important for me.
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>")
vim.keymap.set("n", "<leader>mr", ":MoltenRestart<CR>")
vim.keymap.set("n", "<leader>md", ":MoltenDeinit<CR>")

vim.keymap.set("n", "<leader>me", ":MoltenEvaluateLine<CR>")
vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>")
--vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>")
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })

-- Natrual Movement of cursor
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- code action for LSP
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>")
