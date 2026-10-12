-- Clear highlight on search when hit <ESC> in normal mode
vim.keymap.set("n", "<ESC>", function()
	vim.cmd("nohlsearch")
	vim.fn.setreg("/", "")
end)

-- Set <J>-<K> to be the shortcut of Esc, very important for me.
vim.keymap.set("i", "jk", "<Esc>")

-- Natrual Movement of cursor
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- code action for LSP
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>")
