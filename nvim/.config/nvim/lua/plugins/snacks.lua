return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- lazygit 是按需调用的工具模块，不需要 enabled，这里留空用默认配置。
		-- 只作用于 nvim 里启动的那个 lazygit，命令行直接跑 lazygit 不受影响。
		lazygit = {},
		-- 在 markdown 等文件里直接显示图片（Ghostty 支持 kitty 图形协议）。
		-- 非 PNG 格式靠 ImageMagick 转换；tmux 里需要 allow-passthrough on。
		image = {
			enabled = true,
			doc = {
				-- 图片显示的最大尺寸，单位是终端的列数/行数（不是像素），按比例缩放。
				-- 默认 80x40；molten 的输出图片也读这两个值。
				max_width = 30,
				max_height = 10,
			},
		},
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
