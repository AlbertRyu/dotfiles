return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
			{ "<leader>be", "<cmd>Neotree buffers<cr>", desc = "Buffer explorer" },
			{ "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git status explorer" },
			--{ "<leader>se", "<cmd>Neotree document_symbols<cr>", desc = "Symbols explorer" },
			--Experimental Feature, not there yet
		},
		lazy = false, -- neo-tree will lazily load itself
	},
}
