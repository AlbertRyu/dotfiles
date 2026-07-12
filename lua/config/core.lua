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
