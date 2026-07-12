return {
	"nvim-mini/mini.nvim",
	version = false, -- 或者指定版本号
	lazy = false,
	keys = {
		-- Keymap for MiniFiles
		--{ "<leader>e", ":lua MiniFiles.open()<CR>", desc = "Open mini file" },
		-- For mini.buffer
		{ "<S-h>", ":bprev<CR>", "Previous buffer" },
		{ "<S-l>", ":bnext<CR>", "Next Buffer" },
	},
	config = function()
		require("mini.pairs").setup()
		require("mini.tabline").setup()
		require("mini.sessions").setup({ autoread = true })
		--require("mini.files").setup()
		require("mini.icons").setup()
		require("mini.comment").setup()
		-- 需要哪个模块就 require 哪个
	end,
}
