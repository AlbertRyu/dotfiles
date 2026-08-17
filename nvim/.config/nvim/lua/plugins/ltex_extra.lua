return {
	"barreiroleo/ltex_extra.nvim",
	ft = { "markdown", "tex" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local langs = { "en-US" }
		local did_setup = false

		-- 把词典/规则文件按 client 推给服务端。
		-- ltex_extra 自带的 reload() 依赖 nvim_get_current_buf() 去找 client，
		-- 因此只能作用于"当前聚焦的那一个" client；每个 git root 会起一个独立的
		-- ltex_plus client，各自持有独立的 settings 表，后启动的那些永远拿不到词典。
		-- 这里直接对指定 client 写 settings 并推送，绕开当前 buffer 的限制。
		local function load_for_client(client)
			local fs = require("ltex_extra.utils.fs")
			local settings = client.settings or {}
			settings.ltex = settings.ltex or {}
			for _, lang in ipairs(langs) do
				for key, type in pairs({
					dictionary = "dictionary",
					disabledRules = "disabledRules",
					hiddenFalsePositives = "hiddenFalsePositives",
				}) do
					settings.ltex[key] = settings.ltex[key] or {}
					settings.ltex[key][lang] = fs.loadFile(type, lang)
				end
			end
			client.settings = settings
			client:notify("workspace/didChangeConfiguration", { settings = settings })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not (client and client.name == "ltex_plus") then
					return
				end
				if not did_setup then
					did_setup = true
					require("ltex_extra").setup({
						load_langs = langs, -- 需要加载词典的语言列表
						-- init_check 的加载走 nvim_get_current_buf()，在预览类场景
						-- （如 Neo-tree 预览）会抛 "Error catching ltex client"。
						-- 下面按 client 显式加载，这里关掉。
						init_check = false,
						path = "~/.config/nvim/ltex", -- 词典存储路径，留空则用项目根目录/当前工作目录
						log_level = "none",
					})
				end
				load_for_client(client)
			end,
		})
	end,
}
