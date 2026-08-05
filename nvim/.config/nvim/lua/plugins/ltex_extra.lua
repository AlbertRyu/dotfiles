return {
	"barreiroleo/ltex_extra.nvim",
	ft = { "markdown", "tex" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local did_setup = false
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not (client and client.name == "ltex_plus") then
					return
				end
				-- 预览场景（如 Neo-tree 预览）光标仍在侧边栏里，附加的 buffer 不是
				-- 当前聚焦 buffer。此时 ltex_extra 的 init_check reload 会用
				-- get_current_buf() 找不到 ltex client，抛 "Error catching ltex client"。
				-- 只在真正聚焦该 buffer 时才 setup。
				if args.buf ~= vim.api.nvim_get_current_buf() then
					return
				end
				if did_setup then
					return
				end
				did_setup = true
				require("ltex_extra").setup({
					load_langs = { "en-US" }, -- 需要加载词典的语言列表
					init_check = true,
					path = "~/.config/nvim/ltex", -- 词典存储路径，留空则用项目根目录/当前工作目录
					log_level = "none",
				})
			end,
		})
	end,
}
