do
	-- Enable experimental loader, should be faster, but not 100% stable.
	vim.loader.enable()

	-- Set mouse mode on, easy to drag or resize.
	vim.opt.mouse = "a"

	-- Show the number lines
	vim.opt.number = true

	-- Default use space for tab
	vim.opt.expandtab = true

	-- do not show the current mode because it's useless.
	vim.opt.showmode = false

	-- wrapped line show the same indent as original
	vim.opt.breakindent = true

	vim.opt.wrap = true
	vim.opt.linebreak = true

	--enable redo/undo after close/reopen file
	--This will save the undo/redo history in a seperate file
	vim.opt.undofile = true

	-- Keep the column left to number there, so it's not jitter when LSP is attached.
	vim.opt.signcolumn = "yes"

	--Minimal number of lines above and below the cursor
	vim.opt.scrolloff = 10

	-- ignore care when searching
	vim.opt.ignorecase = true

	-- case sensitive when there's Capital letters.
	vim.opt.smartcase = true
end

-- Regarding the theme
vim.opt.termguicolors = true
vim.cmd.colorscheme("dayfox")

-- Tabsize for each language
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

--- Filetype Detection ---
vim.filetype.add({
	extension = {
		beancount = "beancount",
		bean = "beancount",
	},
})

-- diagnostic related
do
	vim.diagnostic.config({
		update_in_insert = false, -- better performance
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = true, --{ severity = { min = vim.diagnostic.severity.WARN } },

		-- Switch between
		virtual_text = false,
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

	vim.o.updatetime = 300 -- 光标停留多久(毫秒)后触发,默认4000太慢

	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
			})
		end,
	})
end
