return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- lazygit 是按需调用的工具模块，不需要 enabled，这里留空用默认配置。
		-- 只作用于 nvim 里启动的那个 lazygit，命令行直接跑 lazygit 不受影响。
		lazygit = {},
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
