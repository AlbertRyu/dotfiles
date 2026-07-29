return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		lazy = false,
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
		keys = {
			{ "<leader>mi", ":MoltenInit<CR>", desc = "启动 kernel" },
			{ "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "运行当前行" },
			{ "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "重跑 cell" },
			{ "<leader>mo", ":MoltenShowOutput<CR>", desc = "查看输出" },
			{ "<leader>m", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "运行选区" },
		},
	},
}
