return {
	"barreiroleo/ltex_extra.nvim",
	ft = { "markdown", "tex" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "ltex_plus" then
					require("ltex_extra").setup({
						load_langs = { "en-US" }, -- 需要加载词典的语言列表
						init_check = true,
						path = "~/.config/nvim/ltex", -- 词典存储路径，留空则用项目根目录/当前工作目录
						log_level = "none",
					})
				end
			end,
		})
	end,
}
