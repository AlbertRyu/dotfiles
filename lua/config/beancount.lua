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
