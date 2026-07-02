-- Clear highlight on search when hit <ESC> in normal mode
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- Keymap for MiniFiles
vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>")

-- For mini.buffer
vim.keymap.set("n", "<S-h>", ":bprev<CR>")
vim.keymap.set("n", "<S-l>", ":bnext<CR>")

-- For calling Lazygit
vim.keymap.set("n", "<leader>gg", function()
	vim.cmd("terminal Lazygit")
	vim.cmd("startinsert")
end)

-- Toggle Diffview
vim.keymap.set("n", "<leader>go", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")
vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory<CR>")

-- Set <J>-<K> to be the shortcut of Esc, very important for me.
vim.keymap.set("i", "jk", "<Esc>")

-- diagnostic related
do
	vim.diagnostic.config({
		update_in_insert = false, -- better performance
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },

		-- Switch between
		virtual_text = true,
		virtual_lines = false,

		--Auto open the float when moving around diagnostic using [d, and ]d
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({
					bufnr = bufnr,
					scope = "cursor",
					focus = false,
				})
			end,
		},
	})

	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
	vim.keymap.set("n", "<leader>td", function()
		if vim.diagnostic.is_enabled() then
			vim.diagnostic.enable(false)
		else
			vim.diagnostic.enable()
		end
	end, { desc = "toggle diagnostic float" })
end
