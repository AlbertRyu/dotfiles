-- This is when I try to learn the good part of kickstart.nvim

-- The core part
do
	-- Enable experimental loader, should be faster, but not 100% stable.
	vim.loader.enable()
	-- The leader key is set to be <space>. This has to be before any plugin using it.
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

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

	--enable redo/undo after close/reopen file
	--This will save the undo/redo history in a seperate file
	vim.opt.undofile = true

	-- Keep the column left to number there, so it's not jitter when LSP is attached.
	vim.opt.signcolumn = "yes"

	--Minimal number of lines above and below the cursor
	vim.opt.scrolloff = 5
end

-- Tabsize for each language
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- when opening a lua file, run lazydev plugin.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		require("lazydev").setup({})
	end,
})

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/morhetz/gruvbox",
	"https://github.com/edeneast/nightfox.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/conform.nvim",
	--		"https://github.com/akinsho/bufferline.nvim",

	--		Language Server Protocal
	"https://github.com/neovim/nvim-lspconfig",

	--LSP managner
	"https://github.com/mason-org/mason.nvim",

	--- Better status line
	"https://github.com/nvim-lualine/lualine.nvim",

	-- lazydev, let lua-ls know the NeoVim API
	"https://github.com/folke/lazydev.nvim",

	-- better completion
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/saghen/blink.lib",

	-- better diff view
	"https://github.com/sindrets/diffview.nvim",

	-- tree-sitter better parser managner
	"https://github.com/nvim-treesitter/nvim-treesitter",

	"https://github.com/Aasim-A/scrollEOF.nvim",
})

--- beancount-language-server configuration ---
--- I used a multifile structure in beancount ledger
--- Thus i need to set main.bean as the journal_file
--- in order to let the LSP know all the accounts included
--- in the main.bean file. The following code do that automatically

local function find_beancount_main(start_path)
	local main = vim.fs.find(
		{ "main.beancount", "main.bean" },
		{ upward = true, path = vim.fs.dirname(start_path), type = "file" }
	)[1]
	return main
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "beancount",
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		local main = find_beancount_main(bufname)

		vim.lsp.start({
			-- since we fired up lsp here by cmd,
			-- it shouldn't be included in vim.lsp.enable()
			-- any more. For that will start another LSP.
			name = "beancount",
			cmd = { "beancount-language-server", "--stdio" },
			root_dir = vim.fs.dirname(main or bufname),
			init_options = {
				journal_file = main,
			},
		})
	end,
})

-- end of configuration for beancount

vim.lsp.enable({ "lua_ls", "ty", "texlab" })

require("mini.pairs").setup({})
require("mini.icons").setup({})
require("mini.files").setup({})
require("mini.tabline").setup({})
require("mini.sessions").setup({
	autoread = true,
})
--require("mini.git").setup({})
--require("mini.diff").setup({})
--require("mini.completion").setup({})

require("scrollEOF").setup()

require("diffview").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "python", "beancount" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- enable blink completion
local cmp = require("blink.cmp")
--cmp.build():pwait()
cmp.setup()

-- Regarding the theme
vim.opt.termguicolors = true
vim.cmd.colorscheme("dayfox")

require("keymap")
--require("bufferline").setup({})

----------------------------------- settings for conform --------------------------------
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		tex = { "tex-fmt" },
		beancount = { "bean-format" },
	},
})

-- set automatic format after save(:w)
vim.api.nvim_create_autocmd("BufWritePre", { --fire this auto command when "BufWritePre" is fired.
	pattern = "*", -- applys to any file.
	callback = function(args) -- the content of the command.
		require("conform").format({ bufnr = args.buf }) -- args.buf is the id of saved buffer.
	end,
})
----------------------------------- settings for --------------------------------
require("mason").setup()
require("lualine").setup({
	sections = { lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" } },
})

--- Filetype Detection ---
vim.filetype.add({
	extension = {
		beancount = "beancount",
		bean = "beancount",
	},
})
